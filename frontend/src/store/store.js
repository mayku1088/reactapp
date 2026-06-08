import { configureStore } from "@reduxjs/toolkit";
import roomReducer from './roomSlice.js'
import bookingReducer from './bookingSlice.js'
export const store = configureStore({
    reducer:{
        rooms: roomReducer,
        bookings: bookingReducer

    }
});