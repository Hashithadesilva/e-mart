@extends('layouts.app')

@section('title', 'Pay with Stripe - E-Mart')

@section('styles')
<style>
    .stripe-pay-wrapper {
        min-height: 80vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 3rem 1.5rem;
        background: var(--bg-primary);
    }

    .stripe-pay-card {
        background: var(--bg-card);
        border: 1px solid var(--border);
        border-radius: 1.25rem;
        padding: 2.5rem;
        max-width: 520px;
        width: 100%;
        box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
    }

    .stripe-logo-row {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        margin-bottom: 2rem;
    }

    .stripe-logo-row .brand {
        font-size: 1.5rem;
        font-weight: 800;
        color: var(--text-primary);
    }

    .stripe-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        background: #6772e5;
        color: white;
        font-size: 0.7rem;
        font-weight: 700;
        letter-spacing: 0.08em;
        text-transform: uppercase;
        padding: 0.25rem 0.65rem;
        border-radius: 99px;
    }

    .order-summary-title {
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.1em;
        color: var(--text-secondary);
        margin-bottom: 1rem;
    }

    .order-item-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.6rem 0;
        border-bottom: 1px solid var(--border);
        font-size: 0.95rem;
        color: var(--text-primary);
    }

    .order-item-row:last-of-type {
        border-bottom: none;
    }

    .order-item-name {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .qty-badge {
        background: var(--bg-secondary);
        border-radius: 6px;
        padding: 0.1rem 0.4rem;
        font-size: 0.75rem;
        font-weight: 600;
        color: var(--text-secondary);
    }

    .divider {
        border: none;
        border-top: 2px solid var(--border);
        margin: 1rem 0;
    }

    .total-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 1.15rem;
        font-weight: 700;
        color: var(--text-primary);
        margin-bottom: 2rem;
    }

    .total-row .amount {
        color: var(--primary);
        font-size: 1.35rem;
    }

    .stripe-pay-btn {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.75rem;
        background: linear-gradient(135deg, #6772e5 0%, #4f56c7 100%);
        color: white;
        font-size: 1rem;
        font-weight: 700;
        padding: 0.9rem 2rem;
        border: none;
        border-radius: 0.75rem;
        cursor: pointer;
        transition: all 0.2s ease;
        text-decoration: none;
        box-shadow: 0 4px 16px rgba(103, 114, 229, 0.35);
    }

    .stripe-pay-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(103, 114, 229, 0.45);
        color: white;
    }

    .stripe-pay-btn:active {
        transform: translateY(0);
    }

    .stripe-pay-btn svg {
        width: 22px;
        height: 22px;
        flex-shrink: 0;
    }

    .secure-note {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.4rem;
        margin-top: 1rem;
        font-size: 0.78rem;
        color: var(--text-secondary);
    }

    .cancel-link {
        display: block;
        text-align: center;
        margin-top: 1rem;
        font-size: 0.85rem;
        color: var(--text-secondary);
        text-decoration: none;
        transition: color 0.2s;
    }

    .cancel-link:hover {
        color: var(--danger);
    }

    .spinner {
        display: none;
        width: 20px;
        height: 20px;
        border: 2px solid rgba(255,255,255,0.4);
        border-top-color: white;
        border-radius: 50%;
        animation: spin 0.7s linear infinite;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

    .btn-text { transition: opacity 0.2s; }
</style>
@endsection

@section('content')
<div class="stripe-pay-wrapper">
    <div class="stripe-pay-card">

        {{-- Header --}}
        <div class="stripe-logo-row">
            <span class="brand">🛒 E-Mart</span>
            <span class="stripe-badge">
                <svg width="10" height="10" viewBox="0 0 24 24" fill="currentColor"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z"/></svg>
                Secured by Stripe
            </span>
        </div>

        {{-- Order Summary --}}
        <p class="order-summary-title">Order #{{ $order->id }} Summary</p>

        @foreach($order->items as $item)
        <div class="order-item-row">
            <div class="order-item-name">
                <span class="qty-badge">×{{ $item->quantity }}</span>
                {{ $item->product->name ?? 'Product' }}
            </div>
            <span>{{ format_currency($item->price * $item->quantity) }}</span>
        </div>
        @endforeach

        <div class="order-item-row">
            <div class="order-item-name">
                <span class="qty-badge">×1</span>
                Shipping
            </div>
            <span>{{ format_currency(10) }}</span>
        </div>

        <hr class="divider">

        <div class="total-row">
            <span>Total Due</span>
            <span class="amount">{{ format_currency($order->total_amount) }}</span>
        </div>

        {{-- Pay Button (form POST to create session) --}}
        <form action="{{ route('stripe.session', $order->id) }}" method="POST" id="stripeForm" onsubmit="handlePay(this)">
            @csrf
            <button type="submit" class="stripe-pay-btn" id="payBtn">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="1" y="4" width="22" height="16" rx="2" ry="2"/>
                    <line x1="1" y1="10" x2="23" y2="10"/>
                </svg>
                <span class="btn-text">Pay with Stripe</span>
                <span class="spinner" id="btnSpinner"></span>
            </button>
        </form>

        <div class="secure-note">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
            </svg>
            256-bit SSL encryption &bull; Powered by Stripe
        </div>

        <a href="{{ route('orders.show', $order->id) }}" class="cancel-link">← Cancel and return to order</a>
    </div>
</div>
@endsection

@section('scripts')
<script>
    function handlePay(form) {
        const btn = document.getElementById('payBtn');
        document.querySelector('.btn-text').style.opacity = '0.5';
        document.getElementById('btnSpinner').style.display = 'block';
        
        // Disable button after a short delay so the form submission isn't cancelled
        setTimeout(() => {
            btn.disabled = true;
        }, 10);
        
        return true;
    }
</script>
@endsection
