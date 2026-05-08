<div>
    <div class="container" style="padding: 2rem 1.5rem;">
        <h1 class="mb-xl">Checkout</h1>
        
        @if (session()->has('success'))
            <div class="alert alert-success mb-lg" style="background: #d4edda; color: #155724; padding: 1rem; border-radius: var(--radius-md);">
                {{ session('success') }}
            </div>
        @endif
        
        @if (session()->has('error'))
            <div class="alert alert-error mb-lg" style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: var(--radius-md);">
                {{ session('error') }}
            </div>
        @endif
        
        <div class="grid grid-cols-3" style="gap: 2rem;">
            <!-- Checkout Form -->
            <div style="grid-column: span 2;">
                <div class="card">
                    <h3 class="mb-lg">Shipping Information</h3>
                    
                    <form wire:submit.prevent="placeOrder">
                        <div class="grid grid-cols-2 gap-md">
                            <div class="form-group">
                                <label class="form-label">Full Name</label>
                                <input type="text" wire:model="name" class="form-input" required>
                                @error('name') <span class="text-danger">{{ $message }}</span> @enderror
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Phone Number</label>
                                <input type="tel" wire:model="phone" class="form-input" required>
                                @error('phone') <span class="text-danger">{{ $message }}</span> @enderror
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <input type="email" wire:model="email" class="form-input" required>
                            @error('email') <span class="text-danger">{{ $message }}</span> @enderror
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Address</label>
                            <input type="text" wire:model="address" class="form-input" required>
                            @error('address') <span class="text-danger">{{ $message }}</span> @enderror
                        </div>
                        
                        <div class="grid grid-cols-3 gap-md">
                            <div class="form-group">
                                <label class="form-label">City</label>
                                <input type="text" wire:model="city" class="form-input" required>
                                @error('city') <span class="text-danger">{{ $message }}</span> @enderror
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">State/Province</label>
                                <input type="text" wire:model="state" class="form-input" required>
                                @error('state') <span class="text-danger">{{ $message }}</span> @enderror
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">ZIP/Postal Code</label>
                                <input type="text" wire:model="zip" class="form-input" required>
                                @error('zip') <span class="text-danger">{{ $message }}</span> @enderror
                            </div>
                        </div>
                        
                        <!-- Payment Method Selection -->
                        <div class="form-group">
                            <label class="form-label">Payment Method</label>

                            <div class="grid grid-cols-2 gap-md">
                                <!-- Stripe Option -->
                                <label class="payment-method-card" :class="{ 'active': $wire.paymentMethod === 'stripe' }">
                                    <input type="radio" name="paymentMethod" value="stripe" wire:model="paymentMethod" class="payment-method-radio">
                                    <div class="payment-method-content">
                                        <span class="payment-method-icon">💳</span>
                                        <div>
                                            <div class="payment-method-title">Pay with Stripe</div>
                                            <div class="payment-method-subtitle">Card · Secure checkout</div>
                                        </div>
                                    </div>
                                </label>

                                <!-- Cash on Delivery Option -->
                                <label class="payment-method-card" :class="{ 'active': $wire.paymentMethod === 'cash_on_delivery' }">
                                    <input type="radio" name="paymentMethod" value="cash_on_delivery" wire:model="paymentMethod" class="payment-method-radio">
                                    <div class="payment-method-content">
                                        <span class="payment-method-icon">💵</span>
                                        <div>
                                            <div class="payment-method-title">Cash on Delivery</div>
                                            <div class="payment-method-subtitle">Pay when you receive</div>
                                        </div>
                                    </div>
                                </label>
                            </div>

                            @error('paymentMethod') <span class="text-danger">{{ $message }}</span> @enderror
                        </div>

                        <!-- Stripe info note (shown when Stripe is selected) -->
                        <div x-show="$wire.paymentMethod === 'stripe'" x-cloak style="display: none;">
                            <div style="display:flex; align-items:flex-start; gap:0.75rem; padding: 1rem; background: rgba(103,114,229,0.07); border: 1px solid rgba(103,114,229,0.2); border-radius: var(--radius-md); font-size: 0.875rem; color: var(--text-secondary); margin-bottom: 1rem;">
                                <span style="font-size:1.25rem; flex-shrink:0;">🔒</span>
                                <div>
                                    <strong style="color: #6772e5;">Stripe Secure Checkout</strong><br>
                                    You'll be redirected to Stripe's secure payment page to enter your card details.
                                    No card information is stored on our servers.
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Order Notes (Optional)</label>
                            <textarea wire:model="notes" class="form-textarea" placeholder="Any special instructions?"></textarea>
                            @error('notes') <span class="text-danger">{{ $message }}</span> @enderror
                        </div>

                        <button type="submit" id="submit-button" class="btn btn-primary btn-lg w-full" wire:loading.attr="disabled">
                            <span wire:loading.remove>
                                @if($paymentMethod === 'stripe')
                                    Continue to Stripe →
                                @else
                                    Place Order
                                @endif
                            </span>
                            <span wire:loading>
                                <span class="spinner" style="width: 20px; height: 20px; border-width: 2px;"></span>
                                Processing...
                            </span>
                        </button>

                    </form>
                </div>
            </div>
            
            <!-- Order Summary -->
            <div>
                <div class="card" style="position: sticky; top: 100px;">
                    <h3 class="mb-md">Order Summary</h3>
                    
                    <div class="mb-md">
                        @foreach ($cartItems as $item)
                            <div class="flex justify-between mb-sm text-secondary" style="font-size: 0.875rem;">
                                <span>{{ $item['product']['name'] }} × {{ $item['quantity'] }}</span>
                                <span>${{ number_format($item['product']['price'] * $item['quantity'], 2) }}</span>
                            </div>
                        @endforeach
                    </div>
                    
                    <div class="flex justify-between mb-sm">
                        <span>Subtotal:</span>
                        <span>{{ format_currency($subtotal) }}</span>
                    </div>
                    
                    <div class="flex justify-between mb-sm">
                        <span>Tax (10%):</span>
                        <span>{{ format_currency($tax) }}</span>
                    </div>
                    
                    <div class="flex justify-between mb-sm">
                        <span>Shipping:</span>
                        <span>{{ format_currency($shipping) }}</span>
                    </div>
                    
                    <div class="flex justify-between" style="padding-top: 1rem; border-top: 1px solid var(--border-color); font-size: 1.25rem; font-weight: 700;">
                        <span>Total:</span>
                        <span class="text-primary">{{ format_currency($total) }}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
