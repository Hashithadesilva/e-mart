<?php

namespace App\Livewire\Checkout;

use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;
use Livewire\Component;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CheckoutForm extends Component
{
    public $name = '';
    public $email = '';
    public $phone = '';
    public $address = '';
    public $city = '';
    public $state = '';
    public $zip = '';
    public $notes = '';
    public $paymentMethod = 'stripe'; // Default to Stripe
    
    public $cartItems = [];
    public $subtotal = 0;
    public $tax = 0;
    public $shipping = 10.00;
    public $total = 0;

    protected $rules = [
        'name' => 'required|string|max:255',
        'email' => 'required|email|max:255',
        'phone' => 'required|string|max:20',
        'address' => 'required|string|max:500',
        'city' => 'required|string|max:100',
        'state' => 'required|string|max:100',
        'zip' => 'required|string|max:20',
        'notes' => 'nullable|string|max:1000',
        'paymentMethod' => 'required|in:stripe,cash_on_delivery',
    ];

    public function mount()
    {
        $this->loadCart();
        
        // Pre-fill with user data
        $user = Auth::user();
        $this->name = $user->name;
        $this->email = $user->email;
    }

    public function loadCart()
    {
        if (!Auth::check()) {
            redirect('/login');
            return;
        }

        $cart = Cart::where('user_id', Auth::id())->first();
        
        if (!$cart || $cart->items->count() === 0) {
            redirect('/cart');
            return;
        }

        $this->cartItems = $cart->items()
            ->with('product')
            ->get()
            ->toArray();

        $this->calculateTotals();
    }

    public function placeOrder()
    {
        $this->validate();

        if (count($this->cartItems) === 0) {
            session()->flash('error', 'Your cart is empty');
            redirect('/cart');
            return;
        }

        // Validate stock before creating order
        foreach ($this->cartItems as $item) {
            $product = \App\Models\Product::find($item['product_id']);
            if (!$product || $product->stock_quantity < $item['quantity']) {
                session()->flash('error', 'Insufficient stock for ' . ($product->name ?? 'product'));
                return;
            }
        }

        DB::beginTransaction();

        try {
            // Create shipping address string
            $shippingAddress = "{$this->address}, {$this->city}, {$this->state} {$this->zip}";

            // Create order
            $order = Order::create([
                'user_id' => Auth::id(),
                'total_amount' => $this->total,
                'status' => 'pending',
                'shipping_address' => $shippingAddress,
                'phone' => $this->phone,
                'payment_method' => $this->paymentMethod,
                'payment_status' => 'pending',
                'payment_amount' => $this->total,
            ]);

            // Create order items
            foreach ($this->cartItems as $item) {
                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'price' => $item['product']['price'],
                ]);
            }

            DB::commit();

            // Handle payment method
            if ($this->paymentMethod === 'stripe') {
                // Use Livewire's redirect so the AJAX response is handled correctly
                return $this->redirect(route('stripe.pay', $order->id), navigate: false);

            } else {
                // Cash on Delivery
                $this->completeOrder($order);
                session()->flash('success', 'Order placed! Pay on delivery.');
                $this->dispatch('cart-updated');
                return $this->redirect(route('orders.show', $order->id), navigate: false);
            }

        } catch (\Exception $e) {
            DB::rollBack();
            session()->flash('error', 'Failed to place order: ' . $e->getMessage());
        }
    }

    private function completeOrder($order)
    {
        // Update product stock
        foreach ($this->cartItems as $item) {
            $product = \App\Models\Product::find($item['product_id']);
            if ($product) {
                $product->decrement('stock_quantity', $item['quantity']);
            }
        }

        // Clear cart
        $cart = Cart::where('user_id', Auth::id())->first();
        if ($cart) {
            $cart->items()->delete();
            $cart->delete();
        }
    }

    private function calculateTotals()
    {
        $this->subtotal = collect($this->cartItems)->sum(function ($item) {
            return $item['product']['price'] * $item['quantity'];
        });

        $this->tax = $this->subtotal * 0.1;
        $this->total = $this->subtotal + $this->tax + $this->shipping;
    }

    public function render()
    {
        return view('livewire.checkout.checkout-form')->layout('layouts.app', ['title' => 'Checkout - E-Mart']);
    }
}
