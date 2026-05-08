<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class StripeController extends Controller
{
    /**
     * Create a Stripe Checkout Session for a given order and redirect to Stripe.
     */
    public function createSession(Request $request, $orderId)
    {
        $order = Order::where('id', $orderId)
            ->where('user_id', Auth::id())
            ->with('items.product')
            ->firstOrFail();

        if ($order->payment_status === 'paid') {
            return redirect()->route('orders.show', $order->id)
                ->with('info', 'This order has already been paid.');
        }

        \Stripe\Stripe::setApiKey(config('services.stripe.secret'));

        // Build line items from order items
        $lineItems = [];
        foreach ($order->items as $item) {
            // Only pass image if it's a full HTTPS URL (not a local file path)
            $imageUrl = $item->product->image_path ?? null;
            $images   = ($imageUrl && str_starts_with($imageUrl, 'http'))
                ? [$imageUrl]
                : [];

            $lineItems[] = [
                'price_data' => [
                    'currency'     => 'lkr',
                    'unit_amount'  => (int) round($item->price * 100),
                    'product_data' => [
                        'name'   => $item->product->name ?? 'Product #' . $item->product_id,
                        'images' => $images,
                    ],
                ],
                'quantity' => $item->quantity,
            ];
        }

        // Add shipping as a separate line item
        $lineItems[] = [
            'price_data' => [
                'currency'     => 'lkr',
                'unit_amount'  => 1000, // LKR 10.00 shipping
                'product_data' => [
                    'name' => 'Shipping',
                ],
            ],
            'quantity' => 1,
        ];

        try {
            $session = \Stripe\Checkout\Session::create([
                'payment_method_types' => ['card'],
                'line_items'           => $lineItems,
                'mode'                 => 'payment',
                'success_url'          => route('stripe.success') . '?session_id={CHECKOUT_SESSION_ID}',
                'cancel_url'           => route('stripe.cancel') . '?order_id=' . $order->id,
                'customer_email'       => Auth::user()->email,
                'metadata'             => [
                    'order_id' => $order->id,
                    'user_id'  => Auth::id(),
                ],
            ]);

            // Store the Stripe session ID on the order
            $order->update([
                'stripe_checkout_session_id' => $session->id,
                'payment_method'             => 'stripe',
            ]);

            Log::info('Stripe session created', [
                'order_id'   => $order->id,
                'session_id' => $session->id,
            ]);

            return redirect($session->url);

        } catch (\Exception $e) {
            Log::error('Stripe session creation failed: ' . $e->getMessage(), [
                'order_id' => $order->id,
            ]);

            return redirect()->route('orders.show', $order->id)
                ->with('error', 'Could not connect to payment gateway. Please try again.');
        }
    }

    /**
     * Show the Stripe payment initiation page for an order.
     */
    public function pay($orderId)
    {
        $order = Order::where('id', $orderId)
            ->where('user_id', Auth::id())
            ->with('items.product')
            ->firstOrFail();

        if ($order->payment_status === 'paid') {
            return redirect()->route('orders.show', $order->id)
                ->with('info', 'This order has already been paid.');
        }

        return view('stripe.pay', compact('order'));
    }

    /**
     * Handle the successful payment return from Stripe.
     */
    public function success(Request $request)
    {
        $sessionId = $request->query('session_id');

        if (!$sessionId) {
            return redirect('/')->with('error', 'Invalid payment session.');
        }

        $order = Order::where('stripe_checkout_session_id', $sessionId)->first();

        if (!$order) {
            Log::warning('Stripe success callback: order not found for session ' . $sessionId);
            return redirect()->route('orders.index')
                ->with('error', 'Order not found. If your payment was charged, please contact support.');
        }

        // Already processed (webhook may have fired first)
        if ($order->payment_status === 'paid') {
            return view('stripe.success', compact('order'));
        }

        // Verify with Stripe API
        \Stripe\Stripe::setApiKey(config('services.stripe.secret'));

        try {
            $session = \Stripe\Checkout\Session::retrieve($sessionId);

            if ($session->payment_status === 'paid') {
                $order->update([
                    'payment_status'          => 'paid',
                    'stripe_payment_intent_id' => $session->payment_intent,
                    'paid_at'                 => now(),
                    'status'                  => 'processing',
                ]);

                // Reduce stock and clear cart
                $this->fulfillOrder($order);

                Log::info('Order ' . $order->id . ' paid via Stripe success redirect.');

                return view('stripe.success', compact('order'));
            }

        } catch (\Exception $e) {
            Log::error('Stripe success verification failed: ' . $e->getMessage());
        }

        return redirect()->route('checkout.index')
            ->with('error', 'Payment verification failed. Please contact support if you were charged.');
    }

    /**
     * Handle the Stripe payment cancel redirect.
     */
    public function cancel(Request $request)
    {
        $orderId = $request->query('order_id');

        if ($orderId) {
            $order = Order::where('id', $orderId)
                ->where('user_id', Auth::id())
                ->first();

            if ($order && $order->payment_status === 'pending') {
                $order->update([
                    'payment_status' => 'failed',
                    'status'         => 'cancelled',
                ]);

                Log::info('Order ' . $order->id . ' cancelled by user at Stripe checkout.');
            }
        }

        return view('stripe.cancel', ['orderId' => $orderId]);
    }

    /**
     * Reduce product stock and clear the user's cart after successful payment.
     */
    private function fulfillOrder(Order $order): void
    {
        foreach ($order->items as $item) {
            $product = $item->product;
            if ($product) {
                $product->decrement('stock_quantity', $item->quantity);
            }
        }

        $user = $order->user;
        if ($user) {
            $cart = \App\Models\Cart::where('user_id', $user->id)->first();
            if ($cart) {
                $cart->items()->delete();
                $cart->delete();
            }
        }
    }
}
