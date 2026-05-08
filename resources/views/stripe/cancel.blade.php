@extends('layouts.app')

@section('title', 'Payment Cancelled - E-Mart')

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
        max-width: 520px;
        width: 100%;
        text-align: center;
        box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
    }

    .cancel-icon {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: linear-gradient(135deg, #f59e0b, #d97706);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        animation: popIn 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
        box-shadow: 0 6px 24px rgba(245, 158, 11, 0.35);
    }

    @keyframes popIn {
        from { transform: scale(0.5); opacity: 0; }
        to   { transform: scale(1);   opacity: 1; }
    }

    .cancel-icon svg {
        width: 40px;
        height: 40px;
        stroke: white;
        stroke-width: 3;
    }

    .result-title {
        font-size: 1.75rem;
        font-weight: 800;
        color: #f59e0b;
        margin-bottom: 0.5rem;
    }

    .result-subtitle {
        font-size: 1rem;
        color: var(--text-secondary);
        margin-bottom: 2rem;
        line-height: 1.6;
    }

    .info-box {
        background: rgba(245, 158, 11, 0.07);
        border: 1px solid rgba(245, 158, 11, 0.2);
        border-radius: 0.875rem;
        padding: 1.25rem 1.5rem;
        text-align: left;
        margin-bottom: 1.5rem;
    }

    .info-box h4 {
        font-size: 0.85rem;
        font-weight: 700;
        color: #d97706;
        margin-bottom: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.07em;
    }

    .info-box p {
        margin: 0;
        color: var(--text-secondary);
        font-size: 0.875rem;
        line-height: 1.6;
    }

    .help-box {
        background: var(--bg-secondary);
        border-radius: 0.875rem;
        padding: 1.25rem 1.5rem;
        text-align: left;
        margin-bottom: 2rem;
    }

    .help-box h4 {
        font-size: 0.85rem;
        font-weight: 700;
        color: var(--text-primary);
        margin-bottom: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.07em;
    }

    .help-box ul {
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

    .btn-warning {
        background: linear-gradient(135deg, #f59e0b, #d97706);
        color: white;
        font-weight: 700;
        padding: 0.75rem 1.75rem;
        border-radius: 0.75rem;
        text-decoration: none;
        transition: all 0.2s;
        box-shadow: 0 4px 14px rgba(245, 158, 11, 0.3);
        font-size: 0.9rem;
    }

    .btn-warning:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(245, 158, 11, 0.4);
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

    .no-charge-note {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        background: rgba(16, 185, 129, 0.1);
        color: #10b981;
        font-weight: 600;
        font-size: 0.8rem;
        padding: 0.35rem 0.9rem;
        border-radius: 99px;
        margin-bottom: 1.5rem;
    }
</style>
@endsection

@section('content')
<div class="stripe-result-wrapper">
    <div class="stripe-result-card">

        <div class="cancel-icon">
            <svg viewBox="0 0 24 24" fill="none">
                <line x1="18" y1="6" x2="6" y2="18"/>
                <line x1="6" y1="6" x2="18" y2="18"/>
            </svg>
        </div>

        <h1 class="result-title">Payment Cancelled</h1>
        <p class="result-subtitle">
            You cancelled the checkout process. Don't worry — you haven't been charged.
        </p>

        <div class="no-charge-note">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                <polyline points="20 6 9 17 4 12"/>
            </svg>
            No charges made to your card
        </div>

        <div class="info-box">
            <h4>What happened?</h4>
            <p>
                You left the Stripe checkout without completing the payment.
                Your order has been marked as cancelled and your cart items are still available.
            </p>
        </div>

        <div class="help-box">
            <h4>What can you do?</h4>
            <ul>
                <li>Go back to checkout and try paying again</li>
                <li>Try a different card or payment method</li>
                <li>Contact us at <strong>support@emart.lk</strong> if you need help</li>
            </ul>
        </div>

        <div class="action-row">
            <a href="{{ route('checkout.index') }}" class="btn-warning">
                Try Again
            </a>
            <a href="/products" class="btn-outline-sm">
                Keep Browsing
            </a>
        </div>

    </div>
</div>
@endsection
