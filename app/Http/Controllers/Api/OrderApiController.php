<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;

class OrderApiController extends Controller
{
    /**
     * Get order statistics (admin only).
     * Called by GET /api/orders/statistics/admin
     */
    public function statistics()
    {
        $stats = [
            'total_orders'      => Order::count(),
            'pending_orders'    => Order::pending()->count(),
            'processing_orders' => Order::processing()->count(),
            'completed_orders'  => Order::completed()->count(),
            'total_revenue'     => Order::completed()->sum('total_amount'),
            'recent_orders'     => Order::with(['user', 'items.product'])->latest()->take(5)->get(),
        ];

        return response()->json($stats);
    }
}
