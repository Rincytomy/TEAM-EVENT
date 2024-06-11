<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Artisan;

class ConfigController extends Controller
{

    public function clearCache()
    {
        $exitCode = Artisan::call('cache:clear');
        return 'cache:clear';
    }

    public function clearConfig()
    {
        $exitCode = Artisan::call('config:clear');
        return 'config:clear';
    }

    public function clearRoute()
    {
        $exitCode = Artisan::call('route:clear');
        return 'route:clear';
    }


    public function clearDatabase()
    {
        $exitCode = Artisan::call('migrate:fresh');
        return 'migrate:fresh';
    }

    public function clearAll()
    {
        $exitCode = Artisan::call('cache:clear');
        $exitCode = Artisan::call('config:clear');
        $exitCode = Artisan::call('route:clear');
        $exitCode = Artisan::call('migrate:fresh');
        return 'cache:clear, config:clear, route:clear, migrate:fresh';
    }
}
