# AirportDatabaseSQL

This repository contains SQL code to initialize and create tables for a fictional airline database. These tables represent various aspects of airline operations, including passengers, airlines, flights, bookings, boarding passes, baggage, and flight staff.

## DATABASE STRUCTURE 

The database contains the following tables:

1.passengers: Contains information about passengers, including their names, date of birth, citizenship, and passport numbers. airlines: Stores airline information, including airline IDs, country, and name.

2.flights: Represents flight details, including departing and arriving gates, airports, departure, and arrival times. It also has a foreign key relationship with airlines.

3.bookings: Records booking information, such as booking IDs, booking platforms, passenger IDs, and flight IDs. It has foreign key relationships with passengers and flights.

4.boarding_passes: Stores boarding pass information, including QR codes and booking IDs. It has a foreign key relationship with bookings.

5.baggages: Contains baggage information, including baggage IDs, weights, and associated booking IDs. It has a foreign key relationship with bookings.

6.flight_staff: Stores data related to flight staff, including staff IDs, names, citizenship, passport numbers, positions, certification types, years of experience, and staff types. It also has a foreign key relationship with flights and includes a check constraint for staff positions.

## DATA INSERTION 

The SQL code includes INSERT statements to populate the tables with sample data. You can modify these INSERT statements to add your own data or adapt the structure to your specific requirements.
