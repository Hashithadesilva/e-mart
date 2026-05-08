<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

/**
 * Add ON UPDATE CASCADE to all existing foreign key constraints.
 *
 * This migration is written defensively — each foreign key is dropped
 * in its own try/catch block so partial previous runs don't cause failures.
 */
return new class extends Migration
{
    /**
     * Safely drop a foreign key, ignoring errors if it no longer exists
     * (can happen if a previous run partially succeeded before failing).
     */
    private function dropFkSafe(string $table, string $column): void
    {
        try {
            Schema::table($table, function (Blueprint $t) use ($column) {
                $t->dropForeign([$column]);
            });
        } catch (\Throwable $e) {
            // FK was already removed in a previous failed run — safe to ignore
        }
    }

    public function up(): void
    {
        // ── products: category_id → categories ───────────────────────
        $this->dropFkSafe('products', 'category_id');
        Schema::table('products', function (Blueprint $table) {
            $table->foreign('category_id')
                  ->references('id')->on('categories')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });

        // ── carts: user_id → users ────────────────────────────────────
        $this->dropFkSafe('carts', 'user_id');
        Schema::table('carts', function (Blueprint $table) {
            $table->foreign('user_id')
                  ->references('id')->on('users')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });

        // ── cart_items: cart_id → carts, product_id → products ────────
        $this->dropFkSafe('cart_items', 'cart_id');
        $this->dropFkSafe('cart_items', 'product_id');
        Schema::table('cart_items', function (Blueprint $table) {
            $table->foreign('cart_id')
                  ->references('id')->on('carts')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
            $table->foreign('product_id')
                  ->references('id')->on('products')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });

        // ── orders: user_id → users ───────────────────────────────────
        $this->dropFkSafe('orders', 'user_id');
        Schema::table('orders', function (Blueprint $table) {
            $table->foreign('user_id')
                  ->references('id')->on('users')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });

        // ── order_items: order_id → orders, product_id → products ─────
        // Note: product_id is NOT NULL so ON DELETE CASCADE is used
        $this->dropFkSafe('order_items', 'order_id');
        $this->dropFkSafe('order_items', 'product_id');
        Schema::table('order_items', function (Blueprint $table) {
            $table->foreign('order_id')
                  ->references('id')->on('orders')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
            $table->foreign('product_id')
                  ->references('id')->on('products')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });

        // ── reviews: user_id → users, product_id → products ──────────
        $this->dropFkSafe('reviews', 'user_id');
        $this->dropFkSafe('reviews', 'product_id');
        Schema::table('reviews', function (Blueprint $table) {
            $table->foreign('user_id')
                  ->references('id')->on('users')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
            $table->foreign('product_id')
                  ->references('id')->on('products')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });

        // ── wishlists: user_id → users, product_id → products ─────────
        $this->dropFkSafe('wishlists', 'user_id');
        $this->dropFkSafe('wishlists', 'product_id');
        Schema::table('wishlists', function (Blueprint $table) {
            $table->foreign('user_id')
                  ->references('id')->on('users')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
            $table->foreign('product_id')
                  ->references('id')->on('products')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });

        // ── order_status_histories: order_id → orders, created_by → users
        $this->dropFkSafe('order_status_histories', 'order_id');
        $this->dropFkSafe('order_status_histories', 'created_by');
        Schema::table('order_status_histories', function (Blueprint $table) {
            $table->foreign('order_id')
                  ->references('id')->on('orders')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
            $table->foreign('created_by')
                  ->references('id')->on('users')
                  ->onUpdate('cascade')
                  ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        // Revert to original state: only onDelete, no onUpdate

        $this->dropFkSafe('products', 'category_id');
        Schema::table('products', function (Blueprint $table) {
            $table->foreign('category_id')->references('id')->on('categories')->onDelete('cascade');
        });

        $this->dropFkSafe('carts', 'user_id');
        Schema::table('carts', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });

        $this->dropFkSafe('cart_items', 'cart_id');
        $this->dropFkSafe('cart_items', 'product_id');
        Schema::table('cart_items', function (Blueprint $table) {
            $table->foreign('cart_id')->references('id')->on('carts')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
        });

        $this->dropFkSafe('orders', 'user_id');
        Schema::table('orders', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });

        $this->dropFkSafe('order_items', 'order_id');
        $this->dropFkSafe('order_items', 'product_id');
        Schema::table('order_items', function (Blueprint $table) {
            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
        });

        $this->dropFkSafe('reviews', 'user_id');
        $this->dropFkSafe('reviews', 'product_id');
        Schema::table('reviews', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
        });

        $this->dropFkSafe('wishlists', 'user_id');
        $this->dropFkSafe('wishlists', 'product_id');
        Schema::table('wishlists', function (Blueprint $table) {
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
        });

        $this->dropFkSafe('order_status_histories', 'order_id');
        $this->dropFkSafe('order_status_histories', 'created_by');
        Schema::table('order_status_histories', function (Blueprint $table) {
            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
            $table->foreign('created_by')->references('id')->on('users')->onDelete('set null');
        });
    }
};
