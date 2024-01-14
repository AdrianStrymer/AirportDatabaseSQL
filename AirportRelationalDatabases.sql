DROP TABLE IF EXISTS boarding_passes;
DROP TABLE IF EXISTS baggages;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS flight_staff;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS passengers;
DROP TABLE IF EXISTS airlines;

CREATE TABLE passengers
( passenger_id INT(7) PRIMARY KEY,
  first_name CHAR(20) NOT NULL,
  second_name CHAR(20) NOT NULL,
  dob DATE NOT NULL,
  citizenship CHAR(15) NOT NULL,
  passport_num VARCHAR(11) UNIQUE NOT NULL
);

INSERT INTO passengers(passenger_id, first_name, second_name, dob, citizenship, passport_num)
VALUES
 (1111111, 'Bob', 'Smith', '1987-03-28', 'Scottish', '11111111111'),
 (2222222, 'Sarah', 'Barkley', '1945-09-08', 'Irish', '22222222222'),
 (3333333, 'Robert', 'Murphy', '2000-11-04', 'American', '3333333333'),
 (4444444, 'Ryan', 'Bronze', '1956-03-13', 'South African', '4444444444');
 
 CREATE TABLE airlines
( airline_id INT(7) PRIMARY KEY,
  airline_country VARCHAR(30) NOT NULL,
  airline_name VARCHAR(20) UNIQUE NOT NULL
);

INSERT INTO airlines(airline_id, airline_country, airline_name)
VALUES
 (1111112, 'Germany', 'GermanAir'),
 (1111113, 'Spain', 'AirEspana'),
 (1111114, 'Ireland', 'AerLingus');
 
CREATE TABLE flights
( flight_id INT(7) PRIMARY KEY,
  departing_gate INT(3) NOT NULL,
  arriving_gate INT(3) NOT NULL,
  arriving_airport VARCHAR(30) NOT NULL,
  departing_airport VARCHAR(30) NOT NULL,
  departure_time TIME NOT NULL,
  arrival_time TIME NOT NULL,
  airline_id INT(7),
  FOREIGN KEY fk_air(airline_id) REFERENCES airlines(airline_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT
);

INSERT INTO flights(flight_id, departing_gate, arriving_gate, arriving_airport, departing_airport, departure_time, arrival_time, airline_id)
VALUES
 (0000001, 134, 456, 'Galway Airport', 'JFK Airport', '12:15', '18:00', 1111112),
 (0000002, 435, 276, 'Warsaw Airport', 'Galway Airport', '11:00', '2:45', 1111114),
 (0000003, 409, 123, 'Malaga Airport', 'Galway Airport', '18:00', '20:00', 1111113);

CREATE TABLE bookings
( booking_id INT(7) PRIMARY KEY,
  booking_platform VARCHAR(20),
  passenger_id INT(7),
  flight_id INT(7),
  FOREIGN KEY fk_flght(flight_id) REFERENCES flights(flight_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT,
  FOREIGN KEY fk_pass(passenger_id) REFERENCES passengers(passenger_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT
); 

INSERT INTO bookings(booking_id, booking_platform, passenger_id, flight_id)
VALUES
 (5555555, 'Travel Agent', 1111111, 0000002),
 (6666666, 'Airport Website', 2222222, 0000002),
 (7777777, NULL, 3333333, 0000003),
 (8888888, 'Travel Agent', 4444444, 0000003);

CREATE TABLE boarding_passes
( boarding_pass_id INT(7) PRIMARY KEY,
  QR_code VARCHAR(17) UNIQUE NOT NULL,
  booking_id INT(7) UNIQUE,
  FOREIGN KEY fk_book(booking_id) REFERENCES bookings(booking_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT
);

INSERT INTO boarding_passes(boarding_pass_id, QR_code, booking_id)
VALUES
 (1211211, '11111111111111111', 5555555),
 (0900900, '22222222222222222', 6666666),
 (3433433, '33333333333333333', 7777777),
 (5655655, '44444444444444444', 8888888);

CREATE TABLE baggages
( baggage_id INT(7) PRIMARY KEY,
  weight FLOAT(5, 2) NOT NULL,
  booking_id INT(7),
  FOREIGN KEY fk_book(booking_id) REFERENCES bookings(booking_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT
);

INSERT INTO baggages(baggage_id, weight, booking_id)
VALUES
 (1010101, 23.45, 5555555),
 (2020202, 20.67, 6666666),
 (3030303, 19.89, 7777777), 
 (4040404, 16.90, 8888888);

CREATE TABLE flight_staff
( staff_id INT(7) PRIMARY KEY,
  first_name CHAR(20) NOT NULL,
  second_name CHAR(20) NOT NULL,
  citizenship CHAR(15) NOT NULL,
  passport_num INT(11) UNIQUE NOT NULL,
  pos CHAR(15) NOT NULL,
  cert_type CHAR(15),
  years_experience INT(2),
  staff_type CHAR(15),
  flight_id INT(7),
  FOREIGN KEY fk_flight(flight_id) REFERENCES flights(flight_id)
  ON UPDATE CASCADE
  ON DELETE RESTRICT,
  Check((pos='pilot' and cert_type is not null and years_experience is not null and staff_type is null) OR (pos='fattendant' and years_experience is not null and staff_type is not null and cert_type is null))
);

INSERT INTO flight_staff(staff_id, first_name, second_name, citizenship, passport_num, pos, cert_type, years_experience, staff_type, flight_id)
VALUES
 (1111222, 'John', 'Hopkins', 'Irish', 2324567, 'pilot', 'commercial', 5, NULL, 0000002),
 (1111333, 'Adam', 'Kaminski', 'Polish', 5678876, 'pilot', 'commercial', 1, NULL, 0000002),
 (1111444, 'Mark', 'Murphy', 'Irish', 1234247, 'fattendant', NULL, 7, 'head attendant',0000002),
 (1111555, 'Juan', 'Espinoza', 'Spanish', 7564765, 'pilot', 'commercial', 1, NULL, 0000003),
 (1111666, 'Susan', 'Henderson', 'English', 8675823, 'pilot', 'commercial', 10, NULL, 0000003),
 (1111777, 'Ava', 'White', 'Irish', 3453465, 'fattendant', NULL, 4, 'head attendant', 0000003);

SELECT AVG(weight) AS average_weight, sum(weight) AS summed_weight
FROM baggages;

SELECT staff_id, first_name, second_name, pos, years_experience
FROM flight_staff
WHERE pos = 'pilot' AND years_experience < 2
ORDER BY second_name;

SELECT flight_id, AVG(years_experience) AS average_experience
FROM flight_staff
GROUP BY flight_id;

SELECT COUNT(booking_platform)
FROM bookings
WHERE booking_platform = 'Airport Website';

SELECT passenger_id, first_name, second_name, dob
FROM passengers
WHERE dob < '1962-12-12'
ORDER BY dob





  
  





