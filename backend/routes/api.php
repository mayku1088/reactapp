<?php

use App\Http\Controllers\HotelController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great! change to see cache
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/register-hotel', [HotelController::class, 'registerHotel']);

Route::post('/register-room', [HotelController::class, 'registerRoom']);

Route::post('/set-recent-searched-cities', [HotelController::class, 'saveRecentSearched']);

Route::get('/get-rooms', [HotelController::class, 'getRooms']);

Route::get('/get-room-by-id', [HotelController::class, 'getRoomById']);

Route::get('/get-owner-rooms', [HotelController::class, 'getOwnerRooms']);

Route::get('/toggle-room-availability', [HotelController::class, 'toggle']);

Route::post('/check-availability', [HotelController::class, 'checkAvailability']);

Route::post('/create-booking', [HotelController::class, 'createBooking']);

Route::get('/get-user-bookings', [HotelController::class, 'getUserBookings']);
