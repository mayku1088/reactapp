import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

import axios from "axios";

axios.defaults.baseURL = '';//import.meta.env.VITE_BACKEND_URL;

const initialState = {
    bookings_store: [],
    loading: false,
    error: null
};

export const fetchBookings = createAsyncThunk(
    'bookings/fetchBookings',
    async () => {
        const res = await  axios.get('/get-user-bookings');

        return await res.data;
    }
);


export const bookingSlice = createSlice({
    name: 'bookings',
    initialState: initialState,
    extraReducers:(builder) => {
        builder.addCase(fetchBookings.pending, (state) => {
            state.loading = true;
        }).addCase(fetchBookings.fulfilled, (state, action) => {
            state.loading = false;
            console.log('payload', action.payload);
            state.bookings_store = action.payload.dashboardData.bookings;
        }).addCase(fetchBookings.rejected, (state, action) => {
            state.loading = false;
            state.error = action.error.message;
        });
        
    }
});

export default bookingSlice.reducer;