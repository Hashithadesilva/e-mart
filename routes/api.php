<?php

use App\Http\Controllers\Api\ProductApiController;
use App\Http\Controllers\Api\CategoryApiController;
use App\Http\Controllers\Api\ReviewApiController;
use App\Http\Controllers\Api\OrderApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Hash;



// PUBLIC API ROUTES (read-only, for external integrations)
Route::get('/products', [ProductApiController::class, 'index']);
Route::get('/products/{id}', [ProductApiController::class, 'show']);

Route::get('/categories', [CategoryApiController::class, 'index']);
Route::get('/categories/{id}', [CategoryApiController::class, 'show']);

Route::get('/reviews', [ReviewApiController::class, 'index']);


// SANCTUM TOKEN AUTH
// Issue a personal access token (for external / mobile clients)
Route::post('/auth/token', function (Request $request) {
    $request->validate([
        'email'       => 'required|email',
        'password'    => 'required',
        'device_name' => 'required',
    ]);

    $user = \App\Models\User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        return response()->json(['message' => 'Invalid credentials'], 401);
    }

    $token = $user->createToken($request->device_name)->plainTextToken;

    return response()->json(['token' => $token]);
});

// Protected routes (require Authorization: Bearer <token>)
Route::middleware('auth:sanctum')->group(function () {

    Route::get('/user/profile', function (Request $request) {
        return $request->user();
    });

});


// ADMIN API ROUTES (session + admin role)
Route::middleware(['web', 'auth', 'admin'])->group(function () {
    Route::get('/orders/statistics/admin', [OrderApiController::class, 'statistics']);
});
