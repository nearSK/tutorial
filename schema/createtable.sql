-- Database: letisko

-- DROP DATABASE letisko;

CREATE DATABASE letisko
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Slovak_Slovakia.1250'
    LC_CTYPE = 'Slovak_Slovakia.1250'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

CREATE TABLE countries(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    vode VARCHAR(5) NOT NULL
);

CREATE TABLE passengers(
    id SERIAL NOT NULL PRIMARY KEY,
    firstname VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL 
);

CREATE TABLE credit_card(
    id SERIAL NOT NULL PRIMARY KEY,
    passenger_id BIGINT NOT NULL REFERENCES passengers(id),
    number VARCHAR(16) NOT NULL,
    type VARCHAR(10) NOT NULL,
    cvc_number VARCHAR(3) NOT NULL,
    month_expiration INT NOT NULL,
    year_expiration INT NOT NULL
);

CREATE TABLE flights(
    id SERIAL NOT NULL PRIMARY KEY,
    source_airport_id BIGINT NOT NULL REFERENCES airports(id),
    destination_airport_id BIGINT NOT NULL REFERENCES airports(id),
    stops INT NOT NULL,
    kilometres BIGINT NOT NULL,
    departure TIMESTAMP NOT NULL,
    arrival TIMESTAMP NOT NULL
);

CREATE TABLE airports(
    id SERIAL NOT NULL PRIMARY KEY,
    country_id BIGINT NOT NULL REFERENCES countries(id),
    name VARCHAR(50), 
    city VARCHAR(50) NOT NULL
);

CREATE TABLE flight_info(
    id SERIAL NOT NULL PRIMARY KEY,
    flight_id BIGINT NOT NULL REFERENCES flights(id),
    price REAL NOT NULL,
    available_seats INT NOT NULL
);

CREATE TABLE airlines(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE planes(
    id SERIAL NOT NULL PRIMARY KEY,
    airline_id BIGINT NOT NULL REFERENCES airlines(id),
    flight_id BIGINT NOT NULL REFERENCES flights(id),
    model VARCHAR(50) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE flight_tickets(
    id SERIAL NOT NULL PRIMARY KEY,
    passenger_id BIGINT NOT NULL REFERENCES passengers(id),
    flight_info_id BIGINT NOT NULL REFERENCES flight_info(id),
    class VARCHAR(20) NOT NULL,
    seat VARCHAR (5) NOT NULL, 
    status VARCHAR(20) NOT NULL
);

CREATE TABLE luggage(
    id SERIAL NOT NULL PRIMARY KEY,
    flight_ticket_id BIGINT REFERENCES flight_tickets(id),
    weight REAL NOT NULL
);