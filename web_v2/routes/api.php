<?php

use App\Http\Controllers\Api\GaleryController;
use App\Http\Controllers\Api\PhotoController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('/login', [UserController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [UserController::class, 'user']);

    Route::post('/logout', [UserController::class, 'logout']);

    Route::prefix('galery')->group(function () {
        Route::get('/', [GaleryController::class, 'index']);
        Route::get('/{galery}', [GaleryController::class, 'show']);
        Route::post('/{galery}/like', [GaleryController::class, 'like']);
        Route::delete('/{galery}/like', [GaleryController::class, 'unlike']);
    });

    Route::prefix('photo')->group(function () {
        Route::get('/', [PhotoController::class, 'index']);
        Route::get('/{photo}', [PhotoController::class, 'show']);
        Route::post('/{photo}/like', [PhotoController::class, 'like']);
        Route::delete('/{photo}/like', [PhotoController::class, 'unlike']);
    });
});