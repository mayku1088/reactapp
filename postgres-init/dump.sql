--
-- PostgreSQL database dump
--

\restrict akWrGqLMboUcHJtiMwPxfk3Mr3QqrSsMLVJ78OUDxZalEMeRqYDJJLtwto2cW8r

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.0

-- Started on 2026-06-07 16:36:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 24636)
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    id bigint NOT NULL,
    "user" bigint NOT NULL,
    room bigint NOT NULL,
    hotel bigint NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    total_price numeric(10,2),
    guests numeric(2,0),
    status character varying(10),
    payment_method character varying(100) DEFAULT 'Pay At Hotel'::character varying,
    is_paid boolean DEFAULT false,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24635)
-- Name: booking_hotel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_hotel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_hotel_seq OWNER TO postgres;

--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 228
-- Name: booking_hotel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_hotel_seq OWNED BY public.booking.hotel;


--
-- TOC entry 225 (class 1259 OID 24632)
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_id_seq OWNER TO postgres;

--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 225
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- TOC entry 227 (class 1259 OID 24634)
-- Name: booking_room_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_room_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_room_seq OWNER TO postgres;

--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 227
-- Name: booking_room_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_room_seq OWNED BY public.booking.room;


--
-- TOC entry 226 (class 1259 OID 24633)
-- Name: booking_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.booking_user_seq OWNER TO postgres;

--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 226
-- Name: booking_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_user_seq OWNED BY public.booking."user";


--
-- TOC entry 221 (class 1259 OID 24591)
-- Name: hotel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotel (
    name character varying(100) NOT NULL,
    address character varying(100) NOT NULL,
    contact character varying(10) NOT NULL,
    owner bigint NOT NULL,
    city character varying(100) NOT NULL,
    id bigint NOT NULL,
    created_at time with time zone,
    updated_at time with time zone
);


ALTER TABLE public.hotel OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24606)
-- Name: hotel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hotel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hotel_id_seq OWNER TO postgres;

--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 222
-- Name: hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hotel_id_seq OWNED BY public.hotel.id;


--
-- TOC entry 224 (class 1259 OID 24617)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    id bigint NOT NULL,
    hotel bigint,
    room_type character varying(100),
    price_per_night numeric(10,2),
    is_available boolean DEFAULT true,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    amenities jsonb,
    images jsonb
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24616)
-- Name: room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.room_id_seq OWNER TO postgres;

--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 223
-- Name: room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_id_seq OWNED BY public.room.id;


--
-- TOC entry 220 (class 1259 OID 24578)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    _id bigint CONSTRAINT user__id_not_null NOT NULL,
    username character varying(100) CONSTRAINT user_username_not_null NOT NULL,
    email character varying(100) CONSTRAINT user_email_not_null NOT NULL,
    image character varying(100),
    role character varying(100) DEFAULT USER CONSTRAINT user_role_not_null NOT NULL,
    recent_searched_cities character varying(100),
    created_at timestamp with time zone,
    updated_at time with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24577)
-- Name: user__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user__id_seq OWNER TO postgres;

--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 219
-- Name: user__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user__id_seq OWNED BY public.users._id;


--
-- TOC entry 4879 (class 2604 OID 24639)
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 24640)
-- Name: booking user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN "user" SET DEFAULT nextval('public.booking_user_seq'::regclass);


--
-- TOC entry 4881 (class 2604 OID 24641)
-- Name: booking room; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN room SET DEFAULT nextval('public.booking_room_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 24642)
-- Name: booking hotel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN hotel SET DEFAULT nextval('public.booking_hotel_seq'::regclass);


--
-- TOC entry 4876 (class 2604 OID 24607)
-- Name: hotel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel ALTER COLUMN id SET DEFAULT nextval('public.hotel_id_seq'::regclass);


--
-- TOC entry 4877 (class 2604 OID 24620)
-- Name: room id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN id SET DEFAULT nextval('public.room_id_seq'::regclass);


--
-- TOC entry 4874 (class 2604 OID 24581)
-- Name: users _id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN _id SET DEFAULT nextval('public.user__id_seq'::regclass);


--
-- TOC entry 5052 (class 0 OID 24636)
-- Dependencies: 229
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking (id, "user", room, hotel, check_in_date, check_out_date, total_price, guests, status, payment_method, is_paid, created_at, updated_at) FROM stdin;
3	1	7	1	2026-01-10	2026-01-10	10.00	2	ordered	Pay At Hotel	f	2026-01-05 14:20:07+05:30	2026-01-05 14:20:07+05:30
4	1	10	1	2026-01-08	2026-01-08	89.00	1	ordered	Pay At Hotel	f	2026-01-08 15:56:23+05:30	2026-01-08 15:56:23+05:30
5	1	10	1	2026-01-23	2026-01-23	89.00	4	ordered	Pay At Hotel	f	2026-01-08 15:57:42+05:30	2026-01-08 15:57:42+05:30
6	1	10	1	2026-01-22	2026-01-22	89.00	4	ordered	Pay At Hotel	f	2026-01-08 15:58:19+05:30	2026-01-08 15:58:19+05:30
\.


--
-- TOC entry 5044 (class 0 OID 24591)
-- Dependencies: 221
-- Data for Name: hotel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotel (name, address, contact, owner, city, id, created_at, updated_at) FROM stdin;
gurukripa	address	4434343	1	Dubai	2	19:35:54+05:30	19:35:54+05:30
guru	add	878989	1	Singapore	3	11:01:22+05:30	11:01:22+05:30
Oberoi	Bandra west	334343	1	Singapore	1	12:35:13+05:30	12:35:13+05:30
\.


--
-- TOC entry 5047 (class 0 OID 24617)
-- Dependencies: 224
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (id, hotel, room_type, price_per_night, is_available, created_at, updated_at, amenities, images) FROM stdin;
14	1	Luxury Room	78.00	t	2026-01-07 12:29:56+05:30	2026-01-07 12:29:56+05:30	["Free Breakfast", "Room Service"]	["ezgif-4-b753d9323ac2.jpg"]
10	1	Double Bed	89.00	t	2026-01-07 12:24:15+05:30	2026-01-07 14:11:50+05:30	["Free WiFi", "Free Breakfast"]	["ezgif-4-b753d9323ac2.jpg"]
13	1	Family Suite	90.00	f	2026-01-07 12:28:56+05:30	2026-01-07 12:28:56+05:30	["Free Breakfast", "Room Service"]	["ezgif-4-b753d9323ac2.jpg"]
15	1	Double Bed	4.00	f	2026-01-07 12:30:21+05:30	2026-01-07 14:24:27+05:30	["Free Breakfast"]	["for-mug.jpg"]
7	1	Double Bed	5.00	t	2026-01-07 12:16:57+05:30	2026-01-07 14:24:37+05:30	["Free Breakfast", "Room Service"]	["coffee.jpg", "for-mug.jpg"]
17	1	Luxury Room	4.00	t	2026-01-07 12:33:24+05:30	2026-01-07 12:33:24+05:30	["Free WiFi", "Free Breakfast", "Room Service", "Mountain View", "Pool Access"]	["ezgif-4-b753d9323ac2.jpg"]
16	2	Luxury Room	4.00	t	2026-01-07 12:30:42+05:30	2026-01-07 12:30:42+05:30	["Room Service", "Mountain View"]	["coffee.jpg"]
\.


--
-- TOC entry 5043 (class 0 OID 24578)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (_id, username, email, image, role, recent_searched_cities, created_at, updated_at) FROM stdin;
1	mayank	mayank@yopmail.com	image	owner	["Singapore"]	2026-01-03 00:00:00+05:30	14:57:52+05:30
\.


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 228
-- Name: booking_hotel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_hotel_seq', 1, false);


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 225
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_id_seq', 6, true);


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 227
-- Name: booking_room_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_room_seq', 1, false);


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 226
-- Name: booking_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_user_seq', 1, false);


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 222
-- Name: hotel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hotel_id_seq', 3, true);


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 223
-- Name: room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_id_seq', 17, true);


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 219
-- Name: user__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user__id_seq', 1, true);


--
-- TOC entry 4892 (class 2606 OID 24652)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- TOC entry 4888 (class 2606 OID 24615)
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 24626)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 24590)
-- Name: users user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (_id);


--
-- TOC entry 4894 (class 2606 OID 24627)
-- Name: room hotel_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT hotel_fk FOREIGN KEY (hotel) REFERENCES public.hotel(id);


--
-- TOC entry 4893 (class 2606 OID 24601)
-- Name: hotel owner_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT owner_fk FOREIGN KEY (owner) REFERENCES public.users(_id);


-- Completed on 2026-06-07 16:36:54

--
-- PostgreSQL database dump complete
--

\unrestrict akWrGqLMboUcHJtiMwPxfk3Mr3QqrSsMLVJ78OUDxZalEMeRqYDJJLtwto2cW8r

