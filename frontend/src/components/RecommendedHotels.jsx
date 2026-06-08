import React, { useEffect, useState } from 'react'
import HotelCard from './HotelCard'
import { roomsDummyData } from '../assets/assets'
import Title from './Title'
import { useNavigate } from 'react-router-dom'
import { useAppContext } from '../context/AppContext'
import { useDispatch, useSelector } from 'react-redux'
import { fetchRooms } from '../store/roomSlice'

const RecommendedHotels = () => {
    //const navigate = useNavigate();
    const dispatch = useDispatch();

    const {rooms_store, loading, error} = useSelector(state => state.rooms);

    //const {searchedCities} = useAppContext();

    const [recommended, setRecommended] = useState([]);

    
    const filterHotels = () => {
        console.log(searchedCities);
        const filteredHotels = rooms.slice().filter(room => {return searchedCities.includes(room.hotel.city)});

        setRecommended(filteredHotels);
    }

    useEffect(() => {
        
        dispatch(fetchRooms());

    }, [dispatch]);


    if(loading) return <div>Loading...</div>

    if(error) return <div>{error}</div>
  return rooms_store.length > 0 && (
    <div className="flex flex-col items-center px-6 md:px-16 lg:px-24 bg-slate-50 py-20">
        <Title title="Recommended hotels" subTitle="Recommended our blah blah" />
        <div className="flex flex-wrap items-center justify-center gap-6 mt-20">
        {rooms_store.slice(0, 4).map((room, index) => (
            <HotelCard room={room} index={index} key={room.id} />
        ))}
        </div>

        
    </div>
  )
}

export default RecommendedHotels