<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use App\Models\Hotel;
use App\Models\Room;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class HotelController extends Controller
{
    public function saveRecentSearched(Request $request)
    {
        $user = User::where('_id', 1)->first();

        $recent = json_decode($user->recent_searched_cities);

        $recent[] = $request->city;
        //dd(json_encode($recent));
        //$user->recent_searched_cities = json_encode($recent);

        User::where('_id', 1)->update(['recent_searched_cities' => json_encode($recent)]);

        return response()->json(['success' => true]);
    }

    public function registerHotel(Request $request)
    {

        $hotel = Hotel::create([
            'name' => $request->name,
            'address' => $request->address,
            'contact' => $request->contact,
            'owner' => 1,
            'city' => $request->city
        ]);

        return response()->json(['success' => true, 'message' => 'Hotel registered successfully']);
    }

    public function registerRoom(Request $request)
    {
        Log::info($request->all());
        //dd($request->all());
        $data = [
            'hotel' => $request->hotel,
            'room_type' => $request->room_type,
            'amenities' => json_decode($request->amenities),
            'price_per_night' => $request->price_per_night
        ];

        $images = [];

        foreach ($request->images as $image) {
            //dd($image);
            $image->storeAs(
                'images',
                $image->getClientOriginalName()
            );

            $images[] = $image->getClientOriginalName();
        }

        $data['images'] = $images;

        $room = Room::create($data);

        return response()->json(['success' => true, 'message' => 'Room registered successfully']);
    }

    public function getRooms(Request $request)
    {
        $rooms = Room::with('hotel.owns')->get();

        return response()->json(['success' => true, 'rooms' => $rooms]);
    }

    public function getRoomById(Request $request)
    {
        $room = Room::with('hotel.owns')->where('id', $request->id)->first();

        return response()->json(['success' => true, 'room' => $room]);
    }

    public function getOwnerRooms(Request $request)
    {
        $rooms = Room::with('hotel.owns')->get();

        return response()->json(['success' => true, 'rooms' => $rooms]);
    }

    public function toggle(Request $request)
    {
        $room_id = $request->room_id;

        $room = Room::find($room_id);

        $room_availability = !$room->is_available;

        $room->is_available = $room_availability;

        $room->save();


        return response()->json(['success' => true, 'message' => 'Toggled']);
    }

    public function checkAvailability(Request $request)
    {
        $room_id = $request->room_id;

        $check_in_date = $request->check_in_date;

        $check_out_date = $request->check_out_date;

        $booking = Booking::where('room', $room_id)->where('check_in_date', '>=', $check_in_date)->where('check_out_date', '<=', $check_out_date)->first();

        if ($booking) {
            return response()->json(['success' => true, 'message' => 'Already booked', 'is_available' => false]);
        }

        return response()->json(['success' => true, 'message' => 'Room is available', 'is_available' => true]);
    }



    public function createBooking(Request $request)
    {
        $room_id = $request->room_id;

        $check_in_date = $request->check_in_date;

        $check_out_date = $request->check_out_date;

        $booking = Booking::where('room', $room_id)->where('check_in_date', '>=', $check_in_date)->where('check_out_date', '<=', $check_out_date)->first();

        if ($booking) {
            return response()->json(['success' => false, 'message' => 'Already booked', 'is_available' => false]);
        }

        $room = Room::find($room_id);

        $total_price = $room->price_per_night;

        Booking::create([
            'user' => 1,
            'hotel' => $request->hotel,
            'room' => $room_id,
            'check_in_date' => $check_in_date,
            'check_out_date' => $check_out_date,
            'total_price' => $total_price,
            'guests' => $request->guests,
            'status' => 'ordered'

        ]);

        return response()->json(['success' => true, 'message' => 'Booking created']);
    }

    public function getUserBookings(Request $request)
    {
        $bookings = Booking::with('owns', 'roomm', 'hot')->where('user', 1)->get();

        $total_bookings = count($bookings);

        return response()->json(['success' => true, 'dashboardData' => ['bookings' => $bookings, 'totalBookings' => $total_bookings, 'totalRevenue' => 5]]);
    }
}
