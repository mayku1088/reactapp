import React, { useEffect } from 'react'
import HotelCard from './HotelCard'
import { roomsDummyData } from '../assets/assets'
import Title from './Title'
import { useNavigate } from 'react-router-dom'
import { useAppContext } from '../context/AppContext'
import { useDispatch, useSelector } from 'react-redux'
import { fetchRooms } from '../store/roomSlice'

const FeaturedDestination = () => {
    //const navigate = useNavigate();
    const dispatch = useDispatch();

    const {rooms_store, loading, error} = useSelector(state => state.rooms);

    const { navigate} = useAppContext();

    useEffect(() => {
        
      dispatch(fetchRooms());

  }, [dispatch]);

  return rooms_store.length > 0 && (
    <div className="flex flex-col items-center px-6 md:px-16 lg:px-24 bg-slate-50 py-20">
        <Title title="Featured Destination" subTitle="Discover our blah blah" />
        <div className="flex flex-wrap items-center justify-center gap-6 mt-20">
        {rooms_store.slice(0, 4).map((room, index) => (
            <HotelCard room={room} index={index} key={room.id} />
        ))}
        </div>

        <button onClick={() => {
            navigate('/rooms'); scrollTo(0, 0)
        }} className="my-16 px-4 py-2 text-sm font-medium border border-gray-300 rounded bg-white hover:bg-gray-50 transition-all cursor-pointer">View all destinations</button>
    </div>
  )
}

export default FeaturedDestination