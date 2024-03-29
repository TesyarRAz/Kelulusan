<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function login(LoginRequest $request)
    {
        $credentials = $request->all();

        $user = User::query()
        ->when(isset($credentials['email']), function ($query) use ($credentials) {
            $query->where('email', $credentials['email']);
        })
        ->when(isset($credentials['nis']), function ($query) use ($credentials) {
            $query->whereHas('student', function ($query) use ($credentials) {
                $query->where('no_induk', $credentials['nis']);
            });
        })
        ->first();

        if (!Hash::check($credentials['password'], $user->password)) {
            return response()->json([
                'message' => 'Unauthorized'
            ], 401);
        }
        
        auth()->login($user);

        if ($user->hasRole('student'))
        {
            $user->load('student');
        }

        $token = auth()->user()->createToken(config('app.name'))->plainTextToken;

        return response()->json([
            'token' => $token,
            'user' => auth()->user()
        ]);
    }

    public function user()
    {
        if (auth()->user()->hasRole('student'))
        {
            auth()->user()->load('student');
        }

        return response()->json([
            'user' => auth()->user()
        ]);
    }

    public function logout()
    {
        auth()->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logged out'
        ]);
    }
}
