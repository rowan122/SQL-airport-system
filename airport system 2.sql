CREATE DATABASE AirlineReservationSystem;
-- Table: Airline
CREATE TABLE Airline (
    A_ID INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Table: Flight
CREATE TABLE Flight (
    F_ID INT PRIMARY KEY,
    engine VARCHAR(255),
    Departure_time DATETIME,
    Arrival_time DATETIME,
    Destination VARCHAR(255),
    A_ID INT,
    FOREIGN KEY (A_ID) REFERENCES Airline(A_ID)
);

-- Table: Passenger
CREATE TABLE Passenger (
    P_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    DOB DATE,
    Address VARCHAR(255),
    Phone_number VARCHAR(20)
);

-- Table: Admin
CREATE TABLE Admin (
    Admin_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Password VARCHAR(255),
    Email VARCHAR(255),
    Phone_number VARCHAR(20)
);

-- Table: Booking
CREATE TABLE Booking (
    Booking_ID INT PRIMARY KEY,
    Seat_no INT,
    Booking_Date DATE,
    F_ID INT,
    P_ID INT,
    FOREIGN KEY (F_ID) REFERENCES Flight(F_ID),
    FOREIGN KEY (P_ID) REFERENCES Passenger(P_ID)
);

-- Table: Seats
CREATE TABLE Seats (
    Seat_ID INT PRIMARY KEY,
    Class VARCHAR(50),
    total_seats INT,
    available_seats INT,
    F_ID INT,
    FOREIGN KEY (F_ID) REFERENCES Flight(F_ID)
);

-- Table: Payment
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Amount DECIMAL(10, 2),
    Payment_date DATE,
    Payment_method VARCHAR(50),
    P_ID INT,
    FOREIGN KEY (P_ID) REFERENCES Passenger(P_ID)
);

-- Table: Generate
CREATE TABLE Generate (
    Admin_ID INT,
    Payment_ID INT,
    PRIMARY KEY (Admin_ID, Payment_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID)
);

-- Table: Flight_admin
CREATE TABLE Flight_admin (
    F_ID INT,
    Admin_ID INT,
    PRIMARY KEY (F_ID, Admin_ID),
    FOREIGN KEY (F_ID) REFERENCES Flight(F_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID)
);

-- Table: Flight_Passenger
CREATE TABLE Flight_Passenger (
    F_ID INT,
    P_ID INT,
    PRIMARY KEY (F_ID, P_ID),
    FOREIGN KEY (F_ID) REFERENCES Flight(F_ID),
    FOREIGN KEY (P_ID) REFERENCES Passenger(P_ID)
);

-- Table: Seats_Passenger
CREATE TABLE Seats_Passenger (
    Seat_ID INT,
    P_ID INT,
    PRIMARY KEY (Seat_ID, P_ID),
    FOREIGN KEY (Seat_ID) REFERENCES Seats(Seat_ID),
    FOREIGN KEY (P_ID) REFERENCES Passenger(P_ID)
);

-- Table: Manage
CREATE TABLE Manage (
    Booking_ID INT,
    Admin_ID INT,
    PRIMARY KEY (Booking_ID, Admin_ID),
    FOREIGN KEY (Booking_ID) REFERENCES Booking(Booking_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID)
);

-- Table: Track
CREATE TABLE Track (
    Seat_ID INT,
    Admin_ID INT,
    PRIMARY KEY (Seat_ID, Admin_ID),
    FOREIGN KEY (Seat_ID) REFERENCES Seats(Seat_ID),
    FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID)
);

-- Inserting sample data into the Flight_ Passenger table
-- Step 1: Clear Existing Data to Avoid Conflicts
DELETE FROM Flight_Passenger;

-- Step 2: Insert New Data with Duplicate Check
INSERT INTO Flight_Passenger (F_ID, P_ID)
SELECT 1, 1
WHERE NOT EXISTS (
    SELECT 1 FROM Flight_Passenger WHERE F_ID = 1 AND P_ID = 1
);

INSERT INTO Flight_Passenger (F_ID, P_ID)
SELECT 2, 2
WHERE NOT EXISTS (
    SELECT 1 FROM Flight_Passenger WHERE F_ID = 2 AND P_ID = 2
);

INSERT INTO Flight_Passenger (F_ID, P_ID)
SELECT 3, 3
WHERE NOT EXISTS (
    SELECT 1 FROM Flight_Passenger WHERE F_ID = 3 AND P_ID = 3
);

-- Step 3: Verify the Data
SELECT * FROM Flight_Passenger;
-- Inserting sample data into the Seats_Passenger table
INSERT INTO Seats_Passenger (Seat_ID, P_ID)
VALUES
(1, 1),
(3, 2),
(5, 3);
-- Step 1: Check Existing Data in Seats Table
-- This step ensures we know the valid Seat_ID values
SELECT * FROM Seats;

-- Step 2: Insert Data into Seats_Passenger with Existence Check
INSERT INTO Seats_Passenger (Seat_ID, P_ID)
SELECT 1, 1
WHERE EXISTS (
    SELECT 1 FROM Seats WHERE Seat_ID = 1
);

INSERT INTO Seats_Passenger (Seat_ID, P_ID)
SELECT 3, 2
WHERE EXISTS (
    SELECT 1 FROM Seats WHERE Seat_ID = 3
);

INSERT INTO Seats_Passenger (Seat_ID, P_ID)
SELECT 5, 3
WHERE EXISTS (
    SELECT 1 FROM Seats WHERE Seat_ID = 5
);

-- Step 3: Verify the Data in Seats_Passenger Table
SELECT * FROM Seats_Passenger;

-- Inserting sample data into the Manage table
INSERT INTO Manage (Booking_ID, Admin_ID)
VALUES
(1, 1),
(2, 2),
(3, 3);
-- Inserting sample data into the Track table  
INSERT INTO Track (Seat_ID, Admin_ID)
VALUES
(1, 1),
(3, 2),
(5, 3);
-- Inserting sample data into the Booking table
INSERT INTO Booking (Booking_ID, Seat_no, Booking_Date, F_ID, P_ID)
VALUES
(1, 10,'2024-12-01', 1, 1),
(2,12,'2024-12-02', 2, 2),
(3, 5, '2024-12-03', 3, 3);
-- Inserting sample data into the Seats table
INSERT INTO Seats (Seat_ID, Class, total_seats, available_seats, F_ID)
VALUES
(1,'Economy', 150, 100, 1), 
(2,'Business', 50, 30, 1),
(3,'First Class', 20, 10, 2),
(4,'Economy', 180, 140, 2),
(5,'Economy', 200, 180, 3);
-- Inserting sample data into the Payment table
INSERT INTO Payment (Payment_ID, Amount, Payment_date, Payment_method, P_ID) VALUES
(1, 250.00,'2024-12-01', 'Credit Card', 1),
(2, 450.00,'2024-12-02', 'Debit Card', 2),
(3, 550.00,'2024-12-03', 'PayPal', 3);
-- Inserting sample data into the Generate table
INSERT INTO Generate (Admin_ID, Payment_ID)
VALUES
(1, 2),
(2, 2),
(3, 3);
-- Inserting sample data into the Flight_admin table
INSERT INTO Flight_admin (F_ID, Admin_ID)
VALUES 
(1, 1),
(2, 2),
(3, 3);
-- Inserting sample data into the Airline table**
INSERT INTO Airline (A_ID, Name)
SELECT 1, 'Skyline Airlines'
WHERE NOT EXISTS (SELECT 1 FROM Airline WHERE A_ID = 1);

INSERT INTO Airline (A_ID, Name)
SELECT 2, 'Global Air'
WHERE NOT EXISTS (SELECT 1 FROM Airline WHERE A_ID = 2);

INSERT INTO Airline (A_ID, Name)
SELECT 3, 'DreamWing Airways'
WHERE NOT EXISTS (SELECT 1 FROM Airline WHERE A_ID = 3);

SELECT * FROM Airline;

-- Inserting sample data into the Flight table**
INSERT INTO Flight (F_ID, engine, Departure_time, Arrival_time, Destination, A_ID)
SELECT 1, 'Boeing 737', '2024-12-25 10:00:00', '2024-12-25 12:00:00', 'New York', 1
WHERE NOT EXISTS (SELECT 1 FROM Flight WHERE F_ID = 1);

INSERT INTO Flight (F_ID, engine, Departure_time, Arrival_time, Destination, A_ID)
SELECT 2, 'Airbus A320', '2024-12-26 14:30:00', '2024-12-26 16:30:00', 'London', 2
WHERE NOT EXISTS (SELECT 1 FROM Flight WHERE F_ID = 2);

INSERT INTO Flight (F_ID, engine, Departure_time, Arrival_time, Destination, A_ID)
SELECT 3, 'Boeing 787', '2024-12-27 09:00:00', '2024-12-27 11:00:00', 'Tokyo', 3
WHERE NOT EXISTS (SELECT 1 FROM Flight WHERE F_ID = 3);

SELECT * FROM Flight;

-- Inserting sample data into the Passenger table
INSERT INTO Passenger (P_ID, Name, Email, DOB, Address, Phone_number)
SELECT 1, 'John Doe', 'john.doe@email.com', '1990-05-15', '123 Elm St, NY', '123-456-7890'
WHERE NOT EXISTS (SELECT 1 FROM Passenger WHERE P_ID = 1);

INSERT INTO Passenger (P_ID, Name, Email, DOB, Address, Phone_number)
SELECT 2, 'Jane Smith', 'jane.smith@email.com', '1985-08-25', '456 Oak St, London', '987-654-3210'
WHERE NOT EXISTS (SELECT 1 FROM Passenger WHERE P_ID = 2);

INSERT INTO Passenger (P_ID, Name, Email, DOB, Address, Phone_number)
SELECT 3, 'Alice Johnson', 'alice.johnson@email.com', '1992-11-10', '789 Pine St, Tokyo', '555-123-4567'
WHERE NOT EXISTS (SELECT 1 FROM Passenger WHERE P_ID = 3);

SELECT * FROM Passenger;

-- Inserting sample data into the Admin table
INSERT INTO Admin (Admin_ID, Name, Password, Email, Phone_number)
SELECT 1, 'David Lee', 'admin 123', 'david.lee@admin.com', '111-222-3333'
WHERE NOT EXISTS (SELECT 1 FROM Admin WHERE Admin_ID = 1);

INSERT INTO Admin (Admin_ID, Name, Password, Email, Phone_number)
SELECT 2, 'Sara Kim', 'admin 456', 'sara.kim@admin.com', '444-555-6666'
WHERE NOT EXISTS (SELECT 1 FROM Admin WHERE Admin_ID = 2);

INSERT INTO Admin (Admin_ID, Name, Password, Email, Phone_number)
SELECT 3, 'Michael Brown', 'admin789', 'michael.brown@admin.com', '777-888-9999'
WHERE NOT EXISTS (SELECT 1 FROM Admin WHERE Admin_ID = 3);

SELECT * FROM Admin;


SELECT 
    Flight.F_ID, 
    Flight.engine, 
    Flight.Departure_time, 
    Flight.Destination, 
    Flight.Arrival_time, 
    Airline.Name AS Airline_Name
FROM 
    Flight
JOIN 
    Airline ON Flight.A_ID = Airline.A_ID;

SELECT 
    Flight.F_ID, 
    COUNT(Flight_Passenger.P_ID) AS Total_Passengers
FROM 
    Flight
JOIN 
    Flight_Passenger ON Flight.F_ID = Flight_Passenger.F_ID
GROUP BY 
    Flight.F_ID;

SELECT 
    Seats.F_ID, 
    Seats.Class, 
    Seats.total_seats, 
    Seats.available_seats
FROM 
    Seats
JOIN 
    Flight ON Seats.F_ID = Flight.F_ID
WHERE 
    Seats.available_seats > 0;

SELECT 
    Passenger.P_ID, 
    Passenger.Name, 
    Passenger.Email, 
    Booking.Booking_ID, 
    Booking.Booking_Date, 
    Payment.Amount, 
    Payment.Payment_date, 
    Payment.Payment_method
FROM 
    Passenger
JOIN 
    Booking ON Passenger.P_ID = Booking.P_ID
JOIN 
    Payment ON Passenger.P_ID = Payment.P_ID;

SELECT 
    Flight.F_ID, 
    COUNT(Flight_Passenger.P_ID) AS Total_Passengers
FROM 
    Flight
JOIN 
    Flight_Passenger ON Flight.F_ID = Flight_Passenger.F_ID
GROUP BY 
    Flight.F_ID;

SELECT 
    Admin.Admin_ID, 
    Admin.Name AS Admin_Name, 
    Booking.Booking_ID, 
    Passenger.Name AS Passenger_Name
FROM 
    Admin
JOIN 
    Manage ON Admin.Admin_ID = Manage.Admin_ID
JOIN 
    Booking ON Manage.Booking_ID = Booking.Booking_ID
JOIN 
    Passenger ON Booking.P_ID = Passenger.P_ID;

SELECT 
    Flight.F_ID, 
    Flight.Destination, 
    Admin.Name AS Admin_Name
FROM 
    Flight_admin
JOIN 
    Flight ON Flight_admin.F_ID = Flight.F_ID
JOIN 
    Admin ON Flight_admin.Admin_ID = Admin.Admin_ID;

--create view function 
CREATE VIEW FlightDetails AS
SELECT 
    Flight.F_ID, 
    Flight.engine, 
    Flight.Departure_time, 
    Flight.Destination, 
    Flight.Arrival_time, 
    Airline.Name AS Airline_Name,
    COUNT(Flight_Passenger.P_ID) AS Total_Passengers
FROM 
    Flight
JOIN 
    Airline ON Flight.A_ID = Airline.A_ID
JOIN 
    Flight_Passenger ON Flight.F_ID = Flight_Passenger.F_ID
GROUP BY 
    Flight.F_ID, Flight.engine, Flight.Departure_time, Flight.Destination, Flight.Arrival_time, Airline.Name;

--Prevent Insertion of Duplicate Flight Entries
CREATE TRIGGER PreventDuplicateFlight
ON Flight
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Flight WHERE F_ID IN (SELECT F_ID FROM inserted) AND F_ID NOT IN (SELECT F_ID FROM deleted))
    BEGIN
        PRINT 'Duplicate Flight Entry Detected!';
        ROLLBACK TRANSACTION;
    END
END;

--Update Available Seats in the Seats Table When Booking is Made
CREATE TRIGGER UpdateAvailableSeats
ON Booking
AFTER INSERT
AS
BEGIN
    DECLARE @SeatID INT;
    DECLARE @F_ID INT;
    
    SELECT @SeatID = Seat_no, @F_ID = F_ID FROM inserted;
    
    UPDATE Seats
    SET available_seats = available_seats - 1
    WHERE Seat_ID = @SeatID AND F_ID = @F_ID;
END;

--Create Index on F_ID in the Flight Table
CREATE INDEX idx_Flight_F_ID ON Flight(F_ID);

--Create Index on Booking_Date in the Booking Table
CREATE INDEX idx_Booking_Booking_Date ON Booking(Booking_Date);










