@extends('layouts.app')

@section('title', 'Payment Successful - E-Mart')

@section('styles')
<style>
    .stripe-result-wrapper {
        min-height: 80vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 3rem 1.5rem;
        background: var(--bg-primary);
    }

    .stripe-result-card {
        background: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: 1.25rem;
        padding: 3rem 2.5rem;
        max-width: 560px;
        width: 100%;
        text-align: center;
        box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
    }

    .success-icon {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: linear-gradient(135deg, #10b981, #059669);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        animation: popIn 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
        box-shadow: 0 6px 24px rgba(16, 185, 129, 0.35);
    }

    @keyframes popIn {
        from { transform: scale(0.5); opacity: 0; }
        to   { transform: scale(1);   opacity: 1; }
    }

    .success-icon svg {
        width: 40px;
        height: 40px;
        stroke: white;
        stroke-width: 3;
    }

    .result-title {
        font-size: 1.75rem;
        font-weight: 800;
        color: #10b981;
        margin-bottom: 0.5rem;
    }

    .result-subtitle {
        font-size: 1rem;
        color: var(--text-secondary);
        margin-bottom: 2rem;
    }

    .order-detail-box {
        background: var(--bg-secondary);
        border-radius: 0.875rem;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        text-align: left;
    }

    .order-detail-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.5rem 0;
        border-bottom: 1px solid var(--border);
        font-size: 0.9rem;
    }

    .order-detail-row:last-child {
        border-bottom: none;
    }

    .order-detail-label {
        color: var(--text-secondary);
    }

    .order-detail-value {
        font-weight: 600;
        color: var(--text-primary);
    }

    .paid-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.3rem;
        background: rgba(16, 185, 129, 0.12);
        color: #10b981;
        font-size: 0.82rem;
        font-weight: 700;
        padding: 0.2rem 0.7rem;
        border-radius: 99px;
    }

    .next-steps {
        background: rgba(103, 114, 229, 0.08);
        border: 1px solid rgba(103, 114, 229, 0.2);
        border-radius: 0.875rem;
        padding: 1.25rem 1.5rem;
        text-align: left;
        margin-bottom: 2rem;
    }

    .next-steps h4 {
        font-size: 0.85rem;
        font-weight: 700;
        color: #6772e5;
        margin-bottom: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.07em;
    }

    .next-steps ul {
        margin: 0;
        padding-left: 1.5rem;
        color: var(--text-secondary);
        font-size: 0.875rem;
        line-height: 1.8;
    }

    .action-row {
        display: flex;
        gap: 1rem;
        justify-content: center;
        flex-wrap: wrap;
    }

    .btn-success {
        background: linear-gradient(135deg, #10b981, #059669);
        color: white;
        font-weight: 700;
        padding: 0.75rem 1.75rem;
        border-radius: 0.75rem;
        text-decoration: none;
        transition: all 0.2s;
        box-shadow: 0 4px 14px rgba(16, 185, 129, 0.3);
        font-size: 0.9rem;
    }

    .btn-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
        color: white;
    }

    .btn-outline-sm {
        border: 2px solid var(--border);
        color: var(--text-secondary);
        font-weight: 600;
        padding: 0.75rem 1.75rem;
        border-radius: 0.75rem;
        text-decoration: none;
        transition: all 0.2s;
        font-size: 0.9rem;
    }

    .btn-outline-sm:hover {
        border-color: var(--primary);
        color: var(--primary);
    }

    .confetti-row {
        font-size: 1.5rem;
        letter-spacing: 0.5rem;
        margin-bottom: 1rem;
    }
</style>
@endsection

@section('content')
<div class="stripe-result-wrapper">
    <div class="stripe-result-card">

        <div class="confetti-row">🎉🛍️🎊</div>

        <div class="success-icon">
            <svg viewBox="0 0 24 24" fill="none">
                <polyline points="20 6 9 17 4 12"/>
            </svg>
        </div>

        <h1 class="result-title">Payment Successful!</h1>
        <p class="result-subtitle">
            Thank you! Your payment was processed securely via Stripe.
        </p>

        {{-- Order Details --}}
        <div class="order-detail-box">
            <div class="order-detail-row">
                <span class="order-detail-label">Order ID</span>
                <span class="order-detail-value">#{{ $order->id }}</span>
            </div>
            <div class="order-detail-row">
                <span class="order-detail-label">Amount Paid</span>
                <span class="order-detail-value" style="color: #10b981;">{{ format_currency($order->total_amount) }}</span>
            </div>
            <div class="order-detail-row">
                <span class="order-detail-label">Payment Method</span>
                <span class="order-detail-value">Stripe (Card)</span>
            </div>
            <div class="order-detail-row">
                <span class="order-detail-label">Payment Status</span>
                <span class="paid-badge">
                    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"/></svg>
                    Paid
                </span>
            </div>
            @if($order->stripe_payment_intent_id)
            <div class="order-detail-row">
                <span class="order-detail-label">Transaction Ref</span>
                <span class="order-detail-value" style="font-size: 0.75rem; font-family: monospace;">{{ Str::limit($order->stripe_payment_intent_id, 24) }}</span>
            </div>
            @endif
        </div>

        {{-- What's Next --}}
        <div class="next-steps">
            <h4>What happens next?</h4>
            <ul>
                <li>You'll receive an order confirmation email shortly</li>
                <li>We'll notify you when your order ships</li>
                <li>Track your delivery status from your orders page</li>
            </ul>
        </div>

        <div class="action-row">
            <a href="{{ route('orders.show', $order->id) }}" class="btn-success">
                View Order Details
            </a>
            <a href="/products" class="btn-outline-sm">
                Continue Shopping
            </a>
        </div>

    </div>
</div>
@endsection
