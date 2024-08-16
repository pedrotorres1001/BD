IF OBJECT_ID('Flight_Fare', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Fare;
IF OBJECT_ID('Flight_Leg', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Leg;
IF OBJECT_ID('Flight_Seat', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Seat;
IF OBJECT_ID('Flight_Leg_Instance', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Leg_Instance;
IF OBJECT_ID('Flight_Airplane', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Airplane;
IF OBJECT_ID('Flight_Can_land', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Can_land;
IF OBJECT_ID('Flight_Flight', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Flight;
IF OBJECT_ID('Flight_Airplane_Type', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Airplane_Type;
IF OBJECT_ID('Flight_Airport', 'U') IS NOT NULL
	DROP TABLE dbo.Flight_Airport;

CREATE TABLE Flight_Airport (
    City varchar(128) NOT NULL,
    Airport_code varchar(128) NOT NULL,
    [State] varchar(128) NOT NULL,
    [Name] varchar(128) NOT NULL,
    PRIMARY KEY (Airport_code),
)

CREATE TABLE Flight_Airplane_Type (
    Max_seats int NOT NULL,
    [Type_name] varchar(128) NOT NULL,
    Company varchar(128) NOT NULL,
    PRIMARY KEY ([Type_name]),
)

CREATE TABLE Flight_Flight (
    Airline varchar(128) NOT NULL,
    [Number] int NOT NULL,
    [Weekday] varchar(10) NOT NULL,
    PRIMARY KEY ([Number]),
)

CREATE TABLE Flight_Can_land (
    Airport_code varchar(128) NOT NULL REFERENCES Flight_Airport(Airport_code),
    [Type_name] varchar(128) NOT NULL REFERENCES Flight_Airplane_type([Type_name]),
    PRIMARY KEY ([Type_name], Airport_code),
)

CREATE TABLE Flight_Airplane (
    Total_seats int NOT NULL,
    [Type] varchar(128) NOT NULL REFERENCES Flight_Airplane_type([Type_name]),
    Airplane_ID int NOT NULL,
    PRIMARY KEY (Airplane_ID),
)

CREATE TABLE Flight_Leg_Instance (
    Leg_number int NOT NULL,
    [Date] date NOT NULL,
    Flight_number int NOT NULL REFERENCES Flight_Flight(Number),
    No_available_seats int NOT NULL,
    Airport_code varchar(128) NOT NULL REFERENCES Flight_Airport(Airport_code),
    scheduled_departure time NOT NULL,
    scheduled_arrival time NOT NULL,
    Airplane_ID int NOT NULL REFERENCES Flight_Airplane(Airplane_ID),
    PRIMARY KEY (Leg_number, [Date], Flight_number),
)

CREATE TABLE Flight_Seat (
    Seat_number int NOT NULL,
    Leg_number int NOT NULL,
    Date_leg_instance date NOT NULL,
    Flight_number int NOT NULL,
    Costumer_name varchar(128) NOT NULL,
    Cphone varchar(50) NOT NULL,
    PRIMARY KEY (Seat_number, Leg_number, Date_leg_instance, Flight_number),
    FOREIGN KEY (Leg_number, Date_leg_instance, Flight_number) REFERENCES Flight_Leg_Instance(Leg_number, [Date], Flight_number)
)

CREATE TABLE Flight_Leg (
    Leg_number int NOT NULL,
    Flight_number int NOT NULL REFERENCES Flight_Flight(Number),
    Airport_code_dep varchar(128) NOT NULL REFERENCES Flight_Airport(Airport_code),
    Airport_code_arr varchar(128) NOT NULL REFERENCES Flight_Airport(Airport_code),
    Scheduled_departure time NOT NULL,
    Scheduled_arrival time NOT NULL,
    PRIMARY KEY (Leg_number, Flight_number),
)

CREATE TABLE Flight_Fare (
    Restrictions varchar(128) NOT NULL,
    Amount int NOT NULL,
    Code int NOT NULL,
    Flight_number int NOT NULL REFERENCES Flight_Flight(Number),
    PRIMARY KEY (Code, Flight_number),
)