-- What to do with Price attribute
-- Changed table names to be one word
-- On update, on delete statements
-- Changed the street address attribute name to streeAddr

-- How long is a seatClass_ID
-- Difference between seat_ID and seatNum
-- How long is seatNum

-- Normalize variable names with underscores or with lowerUpper

-- Name is seat_class variable is what
-- First Class, Economy, etc?

-- Added name attribute in Flight_Seat
-- Foreign key must reference primary key of another table
-- Or we can make seatClass_ID the primary key in Seat_Class
-- Booking only references Flight_Seat with two of three variables
-- Added seatClass_ID to the Booking

-- Small typo in Flight table, one variable is maxSeats
-- and the other is maxSeat

-- Weird relationship between Flight and Flight_Schedule

-- AirlineID in Booking and Flight
-- How does flightNum from Booking Relate to Flight

-- Feel like Booking should contain a customer, an airline, a seat,
-- and a flight scheduling plus flightNumber
-- or customer, flight, flight_seat


-- Include zip in primary key
-- No duplicate state
CREATE TABLE Address
(
	street_name_num	varchar(100),
	zip				varchar(9),
	city			varchar(50),
	state			varchar(25),
	country			varchar(50),
	addressType		varchar(20),
	PRIMARY KEY (street_name_num, zip)
);

-- done
CREATE TABLE Airport
(
	IATA_airportCode varchar(5),
	airportName		 varchar(100),
	country			 varchar(50),
	city			 varchar(50),
	state			 varchar(25),
	PRIMARY KEY (IATA_airportCode)
);

-- done
CREATE TABLE Airline
(
	AirlineID		varchar(5),
	name 			varchar(100),
	country_origin 	varchar(50),
	PRIMARY KEY (AirlineID)
);

-- done
CREATE TABLE Seat_Class
(
	seatClass_ID	varchar(5),
	name			varchar(50),
	PRIMARY KEY (seatClass_ID, name),
	CHECK (seatClass_ID in ('F', 'E')),
	CHECK (name in ('First Class', 'Economy'))
);

-- done
-- If an airline is deleted then delete all flight info
-- related to that airline

-- added name to relate flight_seat to seat_class
CREATE TABLE Flight_Seat
(
	AirlineID		varchar(5),
	seat_ID			varchar(20),
	seatClass_ID	varchar(5),
	name			varchar(50),
	seatNum 		varchar(5),
	PRIMARY KEY (AirlineID, seat_ID, seatClass_ID),
	FOREIGN KEY (AirlineID) REFERENCES Airline
		ON DELETE CASCADE
		ON UPDATE CASCADE,
FOREIGN KEY (seatClass_ID, name) REFERENCES Seat_Class
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
	
-- done
-- If an airport is deleted then delete all flight info
-- related to that airport
CREATE TABLE Flight_Path
(
	departure_iata 	 varchar(5),
	destination_iata varchar(5),
	PRIMARY KEY (departure_iata, destination_iata),
	FOREIGN KEY (departure_iata) REFERENCES Airport
		ON DELETE CASCADE
		ON UPDATE CASCADE,
FOREIGN KEY (destination_iata) REFERENCES Airport
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- done
-- if a scheduled flight suddenly loses a flight path 
-- delete the flight path
CREATE TABLE Flight_Schedule
(
	schedule_ID		 varchar(50),
	departure_iata   varchar(5),
	destination_iata varchar(5),
	depart_time 	 time,
	arrival_time 	 time,
	PRIMARY KEY (schedule_ID),
	FOREIGN KEY (departure_iata, destination_iata) REFERENCES Flight_Path
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- done
-- If an airline is deleted then delete all flight info
-- related to that airline. If the flight has no schedule
-- make it NULL
CREATE TABLE Flight
(
	AirlineID			varchar(5),
	flightNum   		varchar(20),
	date				date,
	schedule_ID 		varchar(50),
	maxSeats_firstclass int,
	maxSeat_economy     int,
	PRIMARY KEY (AirlineID, flightNum, date, schedule_ID),
	FOREIGN KEY (AirlineID) REFERENCES Airline
		ON DELETE CASCADE
		ON UPDATE CASCADE,
FOREIGN KEY (schedule_ID) REFERENCES Flight_Schedule
		ON DELETE SET NULL
		ON UPDATE CASCADE
);

-- done
-- If customer has airport deleted then set NULL
-- 
CREATE TABLE Customer
(
	email_address	varchar(100),
	name_first		varchar(25),
	name_last		varchar(25),
	name_midInt		char(1),
	address1		varchar(100),
	zip1			varchar(9),
	address2		varchar(100),
	zip2			varchar(9),
	iata_hm_airport	varchar(3),
	PRIMARY KEY (email_address),
	FOREIGN KEY (iata_hm_airport) REFERENCES Airport
		ON DELETE SET NULL
		ON UPDATE CASCADE,
FOREIGN KEY (address1, zip1) REFERENCES Address
		ON DELETE SET NULL
		ON UPDATE CASCADE,
FOREIGN KEY (address2, zip2) REFERENCES Address
		ON DELETE SET NULL
		ON UPDATE CASCADE
);

-- done
CREATE TABLE Booking
(
	email_address	varchar(100),
	AirlineID		varchar(5),
	flightNum		varchar(20),
	date 			date,
	seatID			varchar(20),
	PRIMARY KEY (email_address, AirlineID, flightNum, date, seatID),
	FOREIGN KEY (email_address) REFERENCES Customer
		ON DELETE CASCADE
		ON UPDATE CASCADE,
FOREIGN KEY (AirlineID) REFERENCES Airline
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- done
CREATE TABLE Booked_Seat
(
	email_address	varchar(100),
	AirlineID		varchar(5),
	flightNum		varchar(20),
	date 			date,
	seatID			varchar(20),
	name_first		varchar(25),
	name_last		varchar(25),
	name_midInt		varchar(1),
	price			numeric(10, 2),
	PRIMARY KEY (email_address, AirlineID, flightNum, date, seatID, price),
FOREIGN KEY (email_address) REFERENCES Customer
		ON DELETE CASCADE
		ON UPDATE CASCADE,
FOREIGN KEY (AirlineID) REFERENCES Airline
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- done
CREATE TABLE Credit_Card
(
	card_number		char(16),
	exp_date		varchar(5),
	security_code 	varchar(3),
	email_address	varchar(100),
	payment_address varchar(100),
	payment_zip		varchar(9),
	PRIMARY KEY (card_number),
	FOREIGN KEY (email_address) REFERENCES Customer
		ON DELETE CASCADE
		ON UPDATE CASCADE,
FOREIGN KEY (payment_address, payment_zip) REFERENCES Address
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
