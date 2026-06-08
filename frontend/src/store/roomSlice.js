import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

import axios from "axios";

axios.defaults.baseURL = import.meta.env.VITE_BACKEND_URL;

const initialState = {
    rooms_store: [],
    selectedRoom: null,
    loading: false,
    error: null
};

export const fetchRooms = createAsyncThunk(
    'rooms/fetchRooms',
    async () => {
        const res = await  axios.get('/get-rooms?baba=1');

        return await res.data;
    }
);

export const fetchRoomById = createAsyncThunk(
    'rooms/fetchRoomById',
    async (id) => {
        const res = await  axios.get(`/get-room-by-id?id=${id}`);

        return await res.data;
    }
);

export const roomSlice = createSlice({
    name: 'rooms',
    initialState: initialState,
    extraReducers:(builder) => {
        builder.addCase(fetchRooms.pending, (state) => {
            state.loading = true;
        }).addCase(fetchRooms.fulfilled, (state, action) => {
            state.loading = false;
            console.log('payload', action.payload);
            state.rooms_store = action.payload.rooms;
        }).addCase(fetchRooms.rejected, (state, action) => {
            state.loading = false;
            state.error = action.error.message;
        }) .addCase(fetchRoomById.pending, (state) => {
            state.loading = true;
            state.error = null;
          })
          .addCase(fetchRoomById.fulfilled, (state, action) => {
            state.loading = false;
            state.selectedRoom = action.payload.room;
    
            // 🧠 optional but VERY smart:
            // merge into rooms_store if not already there
            /*const exists = state.rooms_store.find(
              room => room.id === action.payload.id
            );
    
            if (!exists) {
              state.rooms_store.push(action.payload);
            }*/
          })
          .addCase(fetchRoomById.rejected, (state, action) => {
            state.loading = false;
            state.error = action.payload || action.error.message;
          });;
        
    }
});

export default roomSlice.reducer;