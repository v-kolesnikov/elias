--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bookings; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA bookings;


--
-- Name: SCHEMA bookings; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA bookings IS 'Авиаперевозки';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = bookings, pg_catalog;

--
-- Name: bookings_now(); Type: FUNCTION; Schema: bookings; Owner: -
--

CREATE FUNCTION bookings_now() RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE COST 0.00999999978
    AS $$SELECT '2016-10-13 17:00:00'::TIMESTAMP
        AT TIME ZONE 'Europe/Moscow';$$;


--
-- Name: now(); Type: FUNCTION; Schema: bookings; Owner: -
--

CREATE FUNCTION now() RETURNS timestamp with time zone
    LANGUAGE sql IMMUTABLE COST 0.00999999978
    AS $$SELECT '2016-10-13 17:00:00'::TIMESTAMP AT TIME ZONE 'Europe/Moscow';$$;


--
-- Name: FUNCTION now(); Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON FUNCTION now() IS 'Момент времени, относительно которого сформированы данные';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: aircrafts; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE aircrafts (
    aircraft_code character(3) NOT NULL,
    model text NOT NULL,
    range integer NOT NULL,
    CONSTRAINT aircrafts_range_check CHECK ((range > 0))
);


--
-- Name: TABLE aircrafts; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE aircrafts IS 'Самолеты';


--
-- Name: COLUMN aircrafts.aircraft_code; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN aircrafts.aircraft_code IS 'Код самолета, IATA';


--
-- Name: COLUMN aircrafts.model; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN aircrafts.model IS 'Модель самолета';


--
-- Name: COLUMN aircrafts.range; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN aircrafts.range IS 'Максимальная дальность полета, км';


--
-- Name: airports; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE airports (
    airport_code character(3) NOT NULL,
    airport_name text NOT NULL,
    city text NOT NULL,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL,
    timezone text NOT NULL
);


--
-- Name: TABLE airports; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE airports IS 'Аэропорты';


--
-- Name: COLUMN airports.airport_code; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN airports.airport_code IS 'Код аэропорта';


--
-- Name: COLUMN airports.airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN airports.airport_name IS 'Название аэропорта';


--
-- Name: COLUMN airports.city; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN airports.city IS 'Город';


--
-- Name: COLUMN airports.longitude; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN airports.longitude IS 'Координаты аэропорта: долгота';


--
-- Name: COLUMN airports.latitude; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN airports.latitude IS 'Координаты аэропорта: широта';


--
-- Name: COLUMN airports.timezone; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN airports.timezone IS 'Временная зона аэропорта';


--
-- Name: boarding_passes; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE boarding_passes (
    ticket_no character(13) NOT NULL,
    flight_id integer NOT NULL,
    boarding_no integer NOT NULL,
    seat_no character varying(4) NOT NULL
);


--
-- Name: TABLE boarding_passes; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE boarding_passes IS 'Посадочные талоны';


--
-- Name: COLUMN boarding_passes.ticket_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN boarding_passes.ticket_no IS 'Номер билета';


--
-- Name: COLUMN boarding_passes.flight_id; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN boarding_passes.flight_id IS 'Идентификатор рейса';


--
-- Name: COLUMN boarding_passes.boarding_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN boarding_passes.boarding_no IS 'Номер посадочного талона';


--
-- Name: COLUMN boarding_passes.seat_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN boarding_passes.seat_no IS 'Номер места';


--
-- Name: bookings; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE bookings (
    book_ref character(6) NOT NULL,
    book_date timestamp with time zone NOT NULL,
    total_amount numeric(10,2) NOT NULL
);


--
-- Name: TABLE bookings; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE bookings IS 'Бронирования';


--
-- Name: COLUMN bookings.book_ref; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN bookings.book_ref IS 'Номер бронирования';


--
-- Name: COLUMN bookings.book_date; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN bookings.book_date IS 'Дата бронирования';


--
-- Name: COLUMN bookings.total_amount; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN bookings.total_amount IS 'Полная сумма бронирования';


--
-- Name: flights; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE flights (
    flight_id integer NOT NULL,
    flight_no character(6) NOT NULL,
    scheduled_departure timestamp with time zone NOT NULL,
    scheduled_arrival timestamp with time zone NOT NULL,
    departure_airport character(3) NOT NULL,
    arrival_airport character(3) NOT NULL,
    status character varying(20) NOT NULL,
    aircraft_code character(3) NOT NULL,
    actual_departure timestamp with time zone,
    actual_arrival timestamp with time zone,
    CONSTRAINT flights_check CHECK ((scheduled_arrival > scheduled_departure)),
    CONSTRAINT flights_check1 CHECK (((actual_arrival IS NULL) OR ((actual_departure IS NOT NULL) AND (actual_arrival IS NOT NULL) AND (actual_arrival > actual_departure)))),
    CONSTRAINT flights_status_check CHECK (((status)::text = ANY (ARRAY[('On Time'::character varying)::text, ('Delayed'::character varying)::text, ('Departed'::character varying)::text, ('Arrived'::character varying)::text, ('Scheduled'::character varying)::text, ('Cancelled'::character varying)::text])))
);


--
-- Name: TABLE flights; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE flights IS 'Рейсы';


--
-- Name: COLUMN flights.flight_id; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.flight_id IS 'Идентификатор рейса';


--
-- Name: COLUMN flights.flight_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.flight_no IS 'Номер рейса';


--
-- Name: COLUMN flights.scheduled_departure; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.scheduled_departure IS 'Время вылета по расписанию';


--
-- Name: COLUMN flights.scheduled_arrival; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.scheduled_arrival IS 'Время прилёта по расписанию';


--
-- Name: COLUMN flights.departure_airport; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.departure_airport IS 'Аэропорт отправления';


--
-- Name: COLUMN flights.arrival_airport; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.arrival_airport IS 'Аэропорт прибытия';


--
-- Name: COLUMN flights.status; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.status IS 'Статус рейса';


--
-- Name: COLUMN flights.aircraft_code; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.aircraft_code IS 'Код самолета, IATA';


--
-- Name: COLUMN flights.actual_departure; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.actual_departure IS 'Фактическое время вылета';


--
-- Name: COLUMN flights.actual_arrival; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights.actual_arrival IS 'Фактическое время прилёта';


--
-- Name: flights_flight_id_seq; Type: SEQUENCE; Schema: bookings; Owner: -
--

CREATE SEQUENCE flights_flight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flights_flight_id_seq; Type: SEQUENCE OWNED BY; Schema: bookings; Owner: -
--

ALTER SEQUENCE flights_flight_id_seq OWNED BY flights.flight_id;


--
-- Name: flights_v; Type: VIEW; Schema: bookings; Owner: -
--

CREATE VIEW flights_v AS
 SELECT f.flight_id,
    f.flight_no,
    f.scheduled_departure,
    timezone(dep.timezone, f.scheduled_departure) AS scheduled_departure_local,
    f.scheduled_arrival,
    timezone(arr.timezone, f.scheduled_arrival) AS scheduled_arrival_local,
    (f.scheduled_arrival - f.scheduled_departure) AS scheduled_duration,
    f.departure_airport,
    dep.airport_name AS departure_airport_name,
    dep.city AS departure_city,
    f.arrival_airport,
    arr.airport_name AS arrival_airport_name,
    arr.city AS arrival_city,
    f.status,
    f.aircraft_code,
    f.actual_departure,
    timezone(dep.timezone, f.actual_departure) AS actual_departure_local,
    f.actual_arrival,
    timezone(arr.timezone, f.actual_arrival) AS actual_arrival_local,
    (f.actual_arrival - f.actual_departure) AS actual_duration
   FROM flights f,
    airports dep,
    airports arr
  WHERE ((f.departure_airport = dep.airport_code) AND (f.arrival_airport = arr.airport_code));


--
-- Name: VIEW flights_v; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON VIEW flights_v IS 'Рейсы';


--
-- Name: COLUMN flights_v.flight_id; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.flight_id IS 'Идентификатор рейса';


--
-- Name: COLUMN flights_v.flight_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.flight_no IS 'Номер рейса';


--
-- Name: COLUMN flights_v.scheduled_departure; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.scheduled_departure IS 'Время вылета по расписанию';


--
-- Name: COLUMN flights_v.scheduled_departure_local; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.scheduled_departure_local IS 'Время вылета по расписанию, местное время в пункте отправления';


--
-- Name: COLUMN flights_v.scheduled_arrival; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.scheduled_arrival IS 'Время прилёта по расписанию';


--
-- Name: COLUMN flights_v.scheduled_arrival_local; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.scheduled_arrival_local IS 'Время прилёта по расписанию, местное время в пункте прибытия';


--
-- Name: COLUMN flights_v.scheduled_duration; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.scheduled_duration IS 'Планируемая продолжительность полета';


--
-- Name: COLUMN flights_v.departure_airport; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.departure_airport IS 'Код аэропорта отправления';


--
-- Name: COLUMN flights_v.departure_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.departure_airport_name IS 'Название аэропорта отправления';


--
-- Name: COLUMN flights_v.departure_city; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.departure_city IS 'Город отправления';


--
-- Name: COLUMN flights_v.arrival_airport; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.arrival_airport IS 'Код аэропорта прибытия';


--
-- Name: COLUMN flights_v.arrival_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.arrival_airport_name IS 'Название аэропорта прибытия';


--
-- Name: COLUMN flights_v.arrival_city; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.arrival_city IS 'Город прибытия';


--
-- Name: COLUMN flights_v.status; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.status IS 'Статус рейса';


--
-- Name: COLUMN flights_v.aircraft_code; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.aircraft_code IS 'Код самолета, IATA';


--
-- Name: COLUMN flights_v.actual_departure; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.actual_departure IS 'Фактическое время вылета';


--
-- Name: COLUMN flights_v.actual_departure_local; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.actual_departure_local IS 'Фактическое время вылета, местное время в пункте отправления';


--
-- Name: COLUMN flights_v.actual_arrival; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.actual_arrival IS 'Фактическое время прилёта';


--
-- Name: COLUMN flights_v.actual_arrival_local; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.actual_arrival_local IS 'Фактическое время прилёта, местное время в пункте прибытия';


--
-- Name: COLUMN flights_v.actual_duration; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN flights_v.actual_duration IS 'Фактическая продолжительность полета';


--
-- Name: routes; Type: MATERIALIZED VIEW; Schema: bookings; Owner: -
--

CREATE MATERIALIZED VIEW routes AS
 WITH f3 AS (
         SELECT f2.flight_no,
            f2.departure_airport,
            f2.arrival_airport,
            f2.aircraft_code,
            f2.duration,
            array_agg(f2.days_of_week) AS days_of_week
           FROM ( SELECT f1.flight_no,
                    f1.departure_airport,
                    f1.arrival_airport,
                    f1.aircraft_code,
                    f1.duration,
                    f1.days_of_week
                   FROM ( SELECT flights.flight_no,
                            flights.departure_airport,
                            flights.arrival_airport,
                            flights.aircraft_code,
                            (flights.scheduled_arrival - flights.scheduled_departure) AS duration,
                            (to_char(flights.scheduled_departure, 'ID'::text))::integer AS days_of_week
                           FROM flights) f1
                  GROUP BY f1.flight_no, f1.departure_airport, f1.arrival_airport, f1.aircraft_code, f1.duration, f1.days_of_week
                  ORDER BY f1.flight_no, f1.departure_airport, f1.arrival_airport, f1.aircraft_code, f1.duration, f1.days_of_week) f2
          GROUP BY f2.flight_no, f2.departure_airport, f2.arrival_airport, f2.aircraft_code, f2.duration
        )
 SELECT f3.flight_no,
    f3.departure_airport,
    dep.airport_name AS departure_airport_name,
    dep.city AS departure_city,
    f3.arrival_airport,
    arr.airport_name AS arrival_airport_name,
    arr.city AS arrival_city,
    f3.aircraft_code,
    f3.duration,
    f3.days_of_week
   FROM f3,
    airports dep,
    airports arr
  WHERE ((f3.departure_airport = dep.airport_code) AND (f3.arrival_airport = arr.airport_code))
  WITH NO DATA;


--
-- Name: MATERIALIZED VIEW routes; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON MATERIALIZED VIEW routes IS 'Маршруты';


--
-- Name: COLUMN routes.flight_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.flight_no IS 'Номер рейса';


--
-- Name: COLUMN routes.departure_airport; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.departure_airport IS 'Код аэропорта отправления';


--
-- Name: COLUMN routes.departure_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.departure_airport_name IS 'Название аэропорта отправления';


--
-- Name: COLUMN routes.departure_city; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.departure_city IS 'Город отправления';


--
-- Name: COLUMN routes.arrival_airport; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.arrival_airport IS 'Код аэропорта прибытия';


--
-- Name: COLUMN routes.arrival_airport_name; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.arrival_airport_name IS 'Название аэропорта прибытия';


--
-- Name: COLUMN routes.arrival_city; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.arrival_city IS 'Город прибытия';


--
-- Name: COLUMN routes.aircraft_code; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.aircraft_code IS 'Код самолета, IATA';


--
-- Name: COLUMN routes.duration; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.duration IS 'Продолжительность полета';


--
-- Name: COLUMN routes.days_of_week; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN routes.days_of_week IS 'Дни недели, когда выполняются рейсы';


--
-- Name: schema_migrations; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE schema_migrations (
    filename text NOT NULL
);


--
-- Name: seats; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE seats (
    aircraft_code character(3) NOT NULL,
    seat_no character varying(4) NOT NULL,
    fare_conditions character varying(10) NOT NULL,
    CONSTRAINT seats_fare_conditions_check CHECK (((fare_conditions)::text = ANY (ARRAY[('Economy'::character varying)::text, ('Comfort'::character varying)::text, ('Business'::character varying)::text])))
);


--
-- Name: TABLE seats; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE seats IS 'Места';


--
-- Name: COLUMN seats.aircraft_code; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN seats.aircraft_code IS 'Код самолета, IATA';


--
-- Name: COLUMN seats.seat_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN seats.seat_no IS 'Номер места';


--
-- Name: COLUMN seats.fare_conditions; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN seats.fare_conditions IS 'Класс обслуживания';


--
-- Name: ticket_flights; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE ticket_flights (
    ticket_no character(13) NOT NULL,
    flight_id integer NOT NULL,
    fare_conditions character varying(10) NOT NULL,
    amount numeric(10,2) NOT NULL,
    CONSTRAINT ticket_flights_amount_check CHECK ((amount >= (0)::numeric)),
    CONSTRAINT ticket_flights_fare_conditions_check CHECK (((fare_conditions)::text = ANY (ARRAY[('Economy'::character varying)::text, ('Comfort'::character varying)::text, ('Business'::character varying)::text])))
);


--
-- Name: TABLE ticket_flights; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE ticket_flights IS 'Перелеты';


--
-- Name: COLUMN ticket_flights.ticket_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN ticket_flights.ticket_no IS 'Номер билета';


--
-- Name: COLUMN ticket_flights.flight_id; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN ticket_flights.flight_id IS 'Идентификатор рейса';


--
-- Name: COLUMN ticket_flights.fare_conditions; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN ticket_flights.fare_conditions IS 'Класс обслуживания';


--
-- Name: COLUMN ticket_flights.amount; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN ticket_flights.amount IS 'Стоимость перелета';


--
-- Name: tickets; Type: TABLE; Schema: bookings; Owner: -
--

CREATE TABLE tickets (
    ticket_no character(13) NOT NULL,
    book_ref character(6) NOT NULL,
    passenger_id character varying(20) NOT NULL,
    passenger_name text NOT NULL,
    contact_data jsonb
);


--
-- Name: TABLE tickets; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON TABLE tickets IS 'Билеты';


--
-- Name: COLUMN tickets.ticket_no; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN tickets.ticket_no IS 'Номер билета';


--
-- Name: COLUMN tickets.book_ref; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN tickets.book_ref IS 'Номер бронирования';


--
-- Name: COLUMN tickets.passenger_id; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN tickets.passenger_id IS 'Идентификатор пассажира';


--
-- Name: COLUMN tickets.passenger_name; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN tickets.passenger_name IS 'Имя пассажира';


--
-- Name: COLUMN tickets.contact_data; Type: COMMENT; Schema: bookings; Owner: -
--

COMMENT ON COLUMN tickets.contact_data IS 'Контактные данные пассажира';


--
-- Name: flights flight_id; Type: DEFAULT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights ALTER COLUMN flight_id SET DEFAULT nextval('flights_flight_id_seq'::regclass);


--
-- Name: aircrafts aircrafts_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY aircrafts
    ADD CONSTRAINT aircrafts_pkey PRIMARY KEY (aircraft_code);


--
-- Name: airports airports_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY airports
    ADD CONSTRAINT airports_pkey PRIMARY KEY (airport_code);


--
-- Name: boarding_passes boarding_passes_flight_id_boarding_no_key; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_flight_id_boarding_no_key UNIQUE (flight_id, boarding_no);


--
-- Name: boarding_passes boarding_passes_flight_id_seat_no_key; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_flight_id_seat_no_key UNIQUE (flight_id, seat_no);


--
-- Name: boarding_passes boarding_passes_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_pkey PRIMARY KEY (ticket_no, flight_id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (book_ref);


--
-- Name: flights flights_flight_no_scheduled_departure_key; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_flight_no_scheduled_departure_key UNIQUE (flight_no, scheduled_departure);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (flight_id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (aircraft_code, seat_no);


--
-- Name: ticket_flights ticket_flights_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_pkey PRIMARY KEY (ticket_no, flight_id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_no);


--
-- Name: boarding_passes boarding_passes_ticket_no_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY boarding_passes
    ADD CONSTRAINT boarding_passes_ticket_no_fkey FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_flights(ticket_no, flight_id);


--
-- Name: flights flights_aircraft_code_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES aircrafts(aircraft_code);


--
-- Name: flights flights_arrival_airport_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_arrival_airport_fkey FOREIGN KEY (arrival_airport) REFERENCES airports(airport_code);


--
-- Name: flights flights_departure_airport_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_departure_airport_fkey FOREIGN KEY (departure_airport) REFERENCES airports(airport_code);


--
-- Name: seats seats_aircraft_code_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY seats
    ADD CONSTRAINT seats_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES aircrafts(aircraft_code) ON DELETE CASCADE;


--
-- Name: ticket_flights ticket_flights_flight_id_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES flights(flight_id);


--
-- Name: ticket_flights ticket_flights_ticket_no_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY ticket_flights
    ADD CONSTRAINT ticket_flights_ticket_no_fkey FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no);


--
-- Name: tickets tickets_book_ref_fkey; Type: FK CONSTRAINT; Schema: bookings; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_book_ref_fkey FOREIGN KEY (book_ref) REFERENCES bookings(book_ref);


--
-- PostgreSQL database dump complete
--

