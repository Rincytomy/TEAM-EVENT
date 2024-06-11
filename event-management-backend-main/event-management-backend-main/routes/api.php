<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\CompanyController;
use App\Http\Controllers\Api\PostController;
use App\Http\Controllers\Api\GalleryController;
use App\Http\Controllers\Api\JobController;
use App\Http\Controllers\ConfigController;
 
Route::post('login', [AuthController::class, 'login']);
Route::post('register', [AuthController::class, 'register']);

Route::middleware('auth:api')->group(function () {

    Route::apiResources([
        'users' => UserController::class,
        'companies' => CompanyController::class,
        'posts' => PostController::class,
        'galleries' => GalleryController::class,
        'jobs' => JobController::class,
    ]);

    Route::get('logout', [AuthController::class, 'logout']);
    Route::get('user', [UserController::class, 'user']);
    Route::get('unverified-users', [UserController::class, 'unverifiedUsers']);
});


Route::get('get-post', [PostController::class, 'allPosts']);
Route::get('get-jobs', [JobController::class, 'allJobs']);


Route::middleware('config.auth')->group(function () {
    Route::patch('clear-cache', [ConfigController::class, 'clearCache']);
    Route::patch('clear-config', [ConfigController::class, 'clearConfig']);
    Route::patch('clear-route', [ConfigController::class, 'clearRoute']);
    Route::patch('clear-database', [ConfigController::class, 'clearDatabase']);
    Route::patch('clear-all', [ConfigController::class, 'clearAll']);
});
