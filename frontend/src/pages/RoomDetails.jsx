import React, { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'
import { assets, facilityIcons, roomCommonData, roomsDummyData } from '../assets/assets';
import StarRating from '../components/StarRating';
import { useAppContext } from '../context/AppContext';
import toast from 'react-hot-toast';
import { useDispatch, useSelector } from 'react-redux';
import { fetchRoomById } from '../store/roomSlice';

const RoomDetails = () => {
    const {id} = useParams();

    const {axios, navigate} = useAppContext();

    const dispatch = useDispatch();

    const {rooms_store, loading, error} = useSelector(state => state.rooms);

    const roomFromStore = rooms_store.find(r => r.id == id);

    const selectedRoom = useSelector(state => state.rooms.selectedRoom);
    
    const room = roomFromStore || selectedRoom;
    

    const [mainImage, setMainImage] = useState(null);

    const [checkInDate, setCheckInDate] = useState(null);

    const [checkOutDate, setCheckOutDate] = useState(null);

    const [guests, setGuests] = useState(1);

    const [isAvailable, setIsAvailable] = useState(false);

    const checkAvailability = async (e) => {
        

        try{
            const {data} = await axios.post(`/check-availability`, {
                room_id:id,
                check_in_date:checkInDate,
                check_out_date:checkOutDate
            });

            if(data.success){
                if(data.is_available){
                    setIsAvailable(true);
                    toast.success(data.message);
                }else{
                    setIsAvailable(false);
                    toast.error(data.message);
                }
                
                
            }else{
                toast.error(data.message);
            }

        }catch(error){
            toast.error(data.message);
        }
    }

    const onSubmitHandler = async (e) => {
        try{
            e.preventDefault();

            if(!isAvailable){
                console.log('is not');
                return checkAvailability();
            }else{
                
                const {data} =  await axios.post('/create-booking', {
                    room_id: id,
                    hotel: room.hotel.id,
                    user:1, 
                    check_in_date: checkInDate,
                    check_out_date: checkOutDate,
                    guests: guests
                });

                if(data.success){
                    toast.success(data.message);
                    navigate('/my-bookings');

                    scrollTo(0, 0);
                }else{
                    toast.error(data.message);
                }
            }
        }catch(error){
            toast.error(error.message);
        }

    }

    /*useEffect(() => {
        
        if(!rooms_store.length){
            dispatch(fetchRoomById());
            return;
        }

        const room = rooms_store.find((room) => {
            
            return room.id == id
        })

        room && setRoom(room)

        room && setMainImage(room.hotel_image_url[0])
    }, [rooms_store]);*/

    useEffect(() => {
        if (!room && id) {
          dispatch(fetchRoomById(id));
        }
      }, [room, id, dispatch]);

      useEffect(() => {
        if (room?.hotel_image_url?.length) {
          setMainImage(room.hotel_image_url[0]);
        }
      }, [room]);

  return room && ( 
    <div className="py-28 md:py-35 px-4 md:px-16 lg:px-24 xl:px-32">
        {/*Room details */}
        <div className="flex flex-col md:flex-row items-start md:items-center gap-2">
            <h1 className="text-3xl md:text-4xl font-playfair">{room.hotel.name} <span className="font-inter text-sm">({room.room_type})</span></h1>
            <p className="text-xs font-inter py-1.5 px-3 text-white bg-orange-500 rounded-full">20% OFF</p>
        </div>
        {/*Room rating */}
        <div className="flex items-center gap-1 mt-2">
            <StarRating />
            <p className="ml-2">200+ reviews</p>
        </div>

        {/*Room address */}

        <div className="flex items-center gap-1 text-gray-500 mt-2">
            <img src={assets.locationIcon} alt=""  />
            <span>{room.hotel.address}</span>
        </div>

        <div className="flex flex-col lg:flex-row mt-6 gap-6">
            <div className="lg:w-1/2 w-full">
                <img src={mainImage} alt="" className="w-full rounded-xl shadow-lg object-cover" />
            </div>
            <div className="grid grid-cols-2 gap-4 lg:w-1/2 w-full">
                {room?.hotel_image_url.length && room.hotel_image_url.map((image, index) => (
                    <img onClick={() => setMainImage(image)} src={image} key={index} className={`w-full rounded-xl shadow-md object-cover cursor-pointer ${mainImage === image && 'outline-3 outline-orange-500'}`} />
                ))}
            </div>
        </div>

        <div className="flex flex-col md:flex-row md:justify-between mt-10">
            <div className="flex flex-col">
                    <h1 className="text-3xl md:text-4xl font-playfair">Experience luxury like never before</h1>
                    <div className="flex flex-wrap items-center mt-3 mb-6 gap-4">
                        {room.amenities.map((item, index) => (
                            <div key={index} className="flex items-center gap-2 px-3 py-2 rounded-lg bg-gray-100">
                                <img src={facilityIcons[item]} alt="" className="w-5 h-5" />
                                <p className="text-xs">{item}</p>
                            </div>
                        ))}
                    </div>
            </div>

            {/*Room price */}
            <p className="text-2xl font-medium">${room.price_per_night} /night</p>
        </div>

        {/*Checkin checkout form */}
        <form onSubmit={onSubmitHandler} className="flex flex-col md:flex-row items-start md:items-center justify-between bg-white shadow-[0px_0px_20px_rgba(0,0,0,0.15)] p-6 rounded-xl mx-auto mt-16 max-w-6xl">
            <div className="flex flex-col flex-wrap md:flex-row items-start md:items-center gap-4 md:gap-10 text-gray-500">

                <div className="flex flex-col">
                    <label htmlFor="checkInDate" className="font-medium">Check In</label>
                    <input type="date"  onChange={(e) => setCheckInDate(e.target.value)} value={checkInDate} id="checkInDate" placeholder="Check In" className="w-full rounded border border-gray-300 px-3 py-2 mt-1.5 outline-none" required />
                </div>
                <div className="w-px h-15 bg-gray-300/70 max-md:hidden"></div>
                <div className="flex flex-col">
                    <label htmlFor="checkOutDate" className="font-medium">Check Out</label>
                    <input type="date"  onChange={(e) => setCheckOutDate(e.target.value)} value={checkOutDate} id="checkOutDate" placeholder="Check Out" className="w-full rounded border border-gray-300 px-3 py-2 mt-1.5 outline-none" required />
                </div>

                <div className="w-px h-15 bg-gray-300/70 max-md:hidden"></div>
                <div className="flex flex-col">
                    <label htmlFor="guests" className="font-medium">Guests</label>
                    <input onChange={(e) => setGuests(e.target.value)} value={guests} type="number"  id="guests" placeholder="1" className="max-w-20 rounded border border-gray-300 px-3 py-2 mt-1.5 outline-none" required />
                </div>
            </div>

            <button  type="submit" className="bg-primary hover:bg-primary-dull active:scale-95 transition-all text-white rounded-md max-md:w-full max-md:mt-6 md:px-25 py-3 md:py-4 text-base cursor-pointer">
                {isAvailable ? 'Book Now' : 'Check Availability'}
            </button>
        </form>

        {/*Common specs */}
        <div className="mt-25 space-y-4">
            {roomCommonData.map((spec, index) => (
                <div key={index} className="flex items-start gap-2">
                    <img src={spec.icon} alt="" className="w-6.5" />
                    <div>
                        <p className="text-base">{spec.title}</p>
                        <p className="text-gray-500">{spec.description}</p>
                    </div>
                </div>
            ))}
        </div>

        <div className="max-w-3xl border-y border-gray-300 my-15 py-10 text-gray-500">
            <p>Guests lorme ipsum Guests lorme ipsum  Guests lorme ipsum  .Guests lorme ipsum Guests lorme ipsum Guests lorme ipsum Guests lorme ipsum Guests lorme ipsum Guests lorme ipsum .Guests lorme ipsum Guests lorme ipsum Guests lorme ipsum Guests lorme ipsum </p>
        </div>

        <div className="flex flex-col items-start gap-4">
                <div className="flex gap-4">
                    <img src={room.hotel.owner.image} alt="" className="h-14 w-14 md:h-18 md:w-18 rounded-full" />
                    <div>
                        <p className="text-lg md:text-xl">Hosted by {room.hotel.name}</p>
                        <div className="flex items-center mt-1">
                            <StarRating />
                            <p className="ml-2">200+ reviews</p>
                        </div>
                    </div>
                </div>
                <button className="px-6 py-2.5 mt-4 rounded text-white bg-primary hover:bg-primary-dull transition-all cursor-pointer">Contact Now</button>
        </div>
    </div>

    
  );
}

export default RoomDetails