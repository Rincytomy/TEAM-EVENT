<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class ConfigAuth
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        if ($request->header('Config-Auth') == env('CONFIG_AUTH')) {
            return $next($request);
        } else {
            return response()->json('Unauthorized', 401);
        }
    }
}
