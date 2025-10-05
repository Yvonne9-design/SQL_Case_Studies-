-- DDL Command: Clean Slate
DROP DATABASE IF EXISTS MyLibSeat_DB; -- Deletes the whole database if it exists

-- DDL Command: Create and Select
CREATE DATABASE MyLibSeat_DB;
USE MyLibSeat_DB;

USE MyLibSeat_DB; -- Ensure database is selected

CREATE TABLE Student (
    regno VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    credit INT DEFAULT 0,
    PRIMARY KEY (regno)
);

USE MyLibSeat_DB; -- Ensure database is selected

CREATE TABLE Seat (
    Seatno VARCHAR(10) NOT NULL,
    seat_type VARCHAR(50),
    seat_color VARCHAR(30),
    PRIMARY KEY (Seatno)
);

USE MyLibSeat_DB; -- Ensure database is selected

CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    ReservationDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,

    -- Foreign Key (FK) 1: Links to the Student table
    student_regno VARCHAR(10) NOT NULL,
    FOREIGN KEY (student_regno) REFERENCES Student(regno),

    -- Foreign Key (FK) 2: Links to the Seat table
    seat_number VARCHAR(10) NOT NULL,
    FOREIGN KEY (seat_number) REFERENCES Seat(Seatno),

    -- Prevents the same student from booking two seats at the same time
    UNIQUE (student_regno, ReservationDate, StartTime)
);

USE MyLibSeat_DB;

-- Insert data into Student table
INSERT INTO Student (regno, name, phone, email, credit) VALUES
('T3201', 'Alex Lee', '0722111222', 'alex.lee@xyz.ac.ke', 10),
('T3202', 'Maria Cruz', '0733444555', 'maria.cruz@xyz.ac.ke', 8),
('T3203', 'John Doe', '0711999888', 'john.doe@xyz.ac.ke', 12);

-- Insert data into Seat table
INSERT INTO Seat (Seatno, seat_type, seat_color) VALUES
('A101', 'Window Desk', 'Blue'),
('A102', 'Window Desk', 'Blue'),
('B201', 'Reading Carrel', 'Green');

-- Insert data into Reservation table
INSERT INTO Reservation (student_regno, seat_number, ReservationDate, StartTime, EndTime) VALUES
('T3201', 'A101', '2025-10-05', '09:00:00', '11:00:00'),
('T3202', 'B201', '2025-10-05', '11:00:00', '13:00:00');

-- Question 1: Simple Retrieval (All students, sorted by name)
SELECT regno, name
FROM Student
ORDER BY name ASC;

-- Question 2: Retrieval with Filtering (Blue seats only)
SELECT Seatno, seat_type
FROM Seat
WHERE seat_color = 'Blue';

-- Question 3: Retrieval with Joins (Student name who reserved A101)
SELECT
    S.name,
    R.ReservationDate,
    R.StartTime
FROM
    Student S
INNER JOIN
    Reservation R ON S.regno = R.student_regno
WHERE
    R.seat_number = 'A101';
    
    SELECT
    regno,
    name,
    email
FROM
    Student
WHERE
    credit > 9 AND name LIKE 'A%';
    
    SELECT
    seat_type,
    COUNT(Seatno) AS TotalSeats
FROM
    Seat
GROUP BY
    seat_type;
    