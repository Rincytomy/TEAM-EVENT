<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;


class UserController extends Controller
{

    public function index()
    {
        $user = User::with('companies')->where('type', '!=', 'admin')->get();
        return response()->json($user);
    }


    public function show($id)
    {
        $user = User::with('companies')->find($id);
        if (isset($user)) {
            return response()->json($user);
        } else {
            return response()->json('User not found', 404);
        }
    }


    public function update(Request $request, $id)
    {
        $user = User::find($id);
        $user->update($request->all());
        return response()->json($user);
    }


    public function destroy($id)
    {
        $user = User::find($id);
        $user->delete();
        return response()->json('User deleted');
    }


    public function user(Request $request)
    {
        $user = $request->user();
        unset($user['created_at']);
        unset($user['is_active']);
        unset($user['is_verified']);
        
        $company = $user->companies()->first();
        if($user['type'] == 'manager'){
            $user['company'] = $company;
        }
        return response()->json($user);

    }

    
    public function unverifiedUsers()
    {
        $users = User::with('companies')->where('is_verified', 0)->get();
        return response()->json($users);
    }
}
