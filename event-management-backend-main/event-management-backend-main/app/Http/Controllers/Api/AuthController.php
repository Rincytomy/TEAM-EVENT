<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;



class AuthController extends Controller
{
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation Error.',
                'errors' => $validator->errors(),
            ], 422);
        }

        $user = User::where('email', $request->email)->first();
        if (isset($user)) {
            if ($user->is_verified == 0) {
                return response()->json([
                    'message' => 'Your account is not verified. Please wait for admin approval.',
                ], 401);
            }
        } else {
            return response()->json([
                'message' => 'User not found.',
            ], 401);
        }

        $credentials = request(['email', 'password']);
        if (!Auth::attempt($credentials)) {
            return response()->json([
                'message' => 'Unauthorized',
            ], 401);
        }
        $user = $request->user();
        $tokenResult = $user->createToken('Personal Access Token');
        $token = $tokenResult->token;
        $token->save();
        return response()->json([
            'token' => $tokenResult->accessToken,
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->token()->revoke();
        return response()->json([
            'message' => 'Successfully logged out',
        ]);
    }

    public function register(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'first_name' => 'required|string|between:2,100',
                'last_name' => 'required|string|between:1,100',
                'email' => 'required|string|email|max:100|unique:users',
                'phone' => 'required|numeric|digits:10|unique:users',
                'dob' => 'required|date',
                'address' => 'required|string',
                'password' => 'required|string|min:8',
            ]);

            if ($validator->fails()) {
                $errors = $validator->errors();
                $errors = implode(" ", $errors->all());
                return response()->json([
                    'message' => $errors,
                ], 422);
            }

            $user = new User([
                'first_name' => $request->first_name,
                'last_name' => $request->last_name,
                'email' => $request->email,
                'phone' => $request->phone,
                'dob' => $request->dob,
                'address' => $request->address,
                'password' => bcrypt($request->password),
                'type' => $request->type,
            ]);
            $user->save();

            return response()->json([
                'id' => $user->id,
                'token' => $user->createToken('Personal Access Token')->accessToken,
                'type' => $user->type,
                'message' => 'User successfully registered',
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
