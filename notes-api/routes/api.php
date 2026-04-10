<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\NoteController;
use Illuminate\Support\Facades\Route;

// Public Routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Protected Routes (Must have a valid token)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);

    // This creates index, store, show, update, destroy routes automatically
    Route::apiResource('notes', NoteController::class);
});

Route::get('/health', function () {
    return response()->json([
        'status' => 'success',
        'message' => 'Hello from your Ubuntu PC!',
        'time' => now(),
    ]);
});
