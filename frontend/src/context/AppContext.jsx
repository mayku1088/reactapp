import axios from "axios";
import { createContext, useContext, useEffect, useState } from "react";
import {useNavigate} from 'react-router-dom';
import {useAuth, useUser} from "@clerk/clerk-react";
import {toast} from 'react-hot-toast';

axios.defaults.baseURL = import.meta.env.VITE_BACKEND_URL;

const AppContext = createContext();

export const AppProvider = ({children}) => {

    const currency = import.meta.env.VITE_CURRENCY || '$';

    const navigate = useNavigate();

    const {user} = useUser();

    const {getToken} = useAuth();


    const [isOwner, setIsOwner] = useState(false);

    const [showHotelReg, setShowHotelReg] = useState(false);

    const [searchedCities, setSearchedCities] = useState(['Dubai']);

    const [rooms, setRooms] = useState([]);

    const fetchRooms = async () => {
        try{
            const {data} = await axios.get('/get-rooms');

            if(data.success){
                setRooms(data.rooms);
            }else{
                toast.error(error.message);
            }
        }catch(error){
            toast.error(error.message);
        }
    }

    const fetchUser = async () => {
        try{
            const {data} = await axios.get('/user', {headers: {Authorization: `Beared ${await getToken}`}});

            if(data.success){
                setIsOwner(data.role === "hotelOwner");

                //setSearchedCities(data.recentSearchedCities);

            }else{
                //Retry
                setTimeout(() => {
                    fetchUser();
                }, 5000);
            }

        }catch(error){
            toast.error(error.message);
        }
    }

    useEffect(() => {
        if(user){
            fetchUser();
        }
        
    }, [user]);

    useEffect(() => {
        //fetchRooms();
    }, []);

    const value = {
        currency, navigate, user, getToken, isOwner, setIsOwner, axios, showHotelReg, setShowHotelReg, rooms, setRooms, searchedCities, setSearchedCities
    };

    return (
        <AppContext.Provider value={value}>
            {children}
        </AppContext.Provider>
    )
}

export const useAppContext = () => {
    return useContext(AppContext);
}