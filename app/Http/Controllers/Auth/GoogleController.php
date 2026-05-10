<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;

class GoogleController extends Controller
{
    /**
     * Redirect the user to Google's OAuth page.
     */
    public function redirect()
    {
        return Socialite::driver('google')
            ->redirectUrl(route('auth.google.callback'))
            ->redirect();
    }

    /**
     * Handle the callback from Google.
     * Creates a new user or logs in an existing one.
     */
    public function callback()
    {
        try {
            $googleUser = Socialite::driver('google')
                ->redirectUrl(route('auth.google.callback'))
                ->user();
        } catch (\Exception $e) {
            return redirect()->route('login')
                ->withErrors(['email' => 'Google login failed. Please try again.']);
        }

        // 1. Check if a user already linked this Google account
        $user = User::where('google_id', $googleUser->getId())->first();

        if ($user) {
            // Already linked — just log in
            Auth::login($user, true);
            return redirect()->intended('/');
        }

        // 2. Check if a user exists with that email (they registered normally before)
        $user = User::where('email', $googleUser->getEmail())->first();

        if ($user) {
            // Link Google to their existing account
            $user->update([
                'google_id'     => $googleUser->getId(),
                'google_avatar' => $googleUser->getAvatar(),
            ]);

            Auth::login($user, true);
            return redirect()->intended('/');
        }

        // 3. Brand new user — create an account
        $user = User::create([
            'name'              => $googleUser->getName(),
            'email'             => $googleUser->getEmail(),
            'google_id'         => $googleUser->getId(),
            'google_avatar'     => $googleUser->getAvatar(),
            'password'          => bcrypt(Str::random(32)), // random password — can reset later
            'email_verified_at' => now(),                   // Google already verified the email
            'role'              => 'customer',
        ]);

        Auth::login($user, true);
        return redirect()->intended('/');
    }
}
