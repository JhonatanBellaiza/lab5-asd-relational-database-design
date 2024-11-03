
CREATE TABLE Dentist (
    dentist_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    contact_phone VARCHAR(15),
    email VARCHAR(50),
    specialization VARCHAR(50)
);

-- Patient Table
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    contact_phone VARCHAR(15),
    email VARCHAR(50),
    mailing_address TEXT,
    date_of_birth DATE
);

-- Surgery Location Table
CREATE TABLE SurgeryLocation (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    address TEXT,
    phone VARCHAR(15)
);

-- Appointment Table
CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_date DATE,
    appointment_time TIME,
    dentist_id INT,
    patient_id INT,
    location_id INT,
    FOREIGN KEY (dentist_id) REFERENCES Dentist(dentist_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (location_id) REFERENCES SurgeryLocation(location_id)
);

-- Bill Table
CREATE TABLE Bill (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    appointment_id INT,
    amount DECIMAL(10, 2),
    is_paid BOOLEAN,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- DATA INPUT

-- Inserting into Dentist
INSERT INTO Dentist (first_name, last_name, contact_phone, email, specialization)
VALUES ('John', 'Doe', '1234567890', 'johndoe@example.com', 'Orthodontics'),
       ('Jane', 'Smith', '0987654321', 'janesmith@example.com', 'Pediatric Dentistry'),
       ('Alice', 'Johnson', '1122334455', 'alicejohnson@example.com', 'Endodontics'),
       ('Robert', 'Brown', '2233445566', 'robertbrown@example.com', 'Oral Surgery'),
       ('Emily', 'Davis', '3344556677', 'emilydavis@example.com', 'Periodontics');

-- Inserting into Patient
INSERT INTO Patient (first_name, last_name, contact_phone, email, mailing_address, date_of_birth)
VALUES ('Michael', 'Green', '5551234567', 'michaelgreen@example.com', '123 Elm Street', '1980-05-15'),
       ('Sarah', 'White', '5552345678', 'sarahwhite@example.com', '456 Oak Street', '1992-08-24'),
       ('David', 'Black', '5553456789', 'davidblack@example.com', '789 Pine Street', '1987-03-10'),
       ('Laura', 'Blue', '5554567890', 'laurablue@example.com', '321 Maple Avenue', '1995-12-01'),
       ('James', 'Yellow', '5555678901', 'jamesyellow@example.com', '654 Cedar Lane', '2000-07-14');

-- Inserting into SurgeryLocation
INSERT INTO SurgeryLocation (name, address, phone)
VALUES ('Downtown Clinic', '101 Main Street', '5551010101'),
       ('Uptown Clinic', '202 Broad Street', '5552020202'),
       ('Eastside Clinic', '303 East Avenue', '5553030303'),
       ('Westside Clinic', '404 West Drive', '5554040404');

-- Inserting into Appointment
INSERT INTO Appointment (appointment_date, appointment_time, dentist_id, patient_id, location_id)
VALUES ('2024-11-10', '09:00:00', 1, 1, 1),
       ('2024-11-10', '10:00:00', 1, 2, 1),
       ('2024-11-11', '11:00:00', 2, 3, 2),
       ('2024-11-12', '14:00:00', 3, 4, 3),
       ('2024-11-13', '15:30:00', 4, 5, 4);

-- Inserting into Bill
INSERT INTO Bill (patient_id, appointment_id, amount, is_paid)
VALUES (1, 1, 200.00, TRUE),
       (2, 2, 150.00, FALSE),
       (3, 3, 300.00, TRUE),
       (4, 4, 250.00, FALSE),
       (5, 5, 180.00, TRUE);


-- List of all Dentists sorted by last name:
SELECT * FROM Dentist
ORDER BY last_name ASC;

-- List of all Appointments for a given Dentist with Patient information:
SELECT Appointment.*, Patient.first_name, Patient.last_name, Patient.contact_phone, Patient.email
FROM Appointment
JOIN Patient ON Appointment.patient_id = Patient.patient_id
WHERE Appointment.dentist_id = 4;

-- List of all Appointments scheduled at a specific Surgery Location:

SELECT Appointment.*, Dentist.first_name AS dentist_first_name, Dentist.last_name AS dentist_last_name,
       Patient.first_name AS patient_first_name, Patient.last_name AS patient_last_name
FROM Appointment
JOIN Dentist ON Appointment.dentist_id = Dentist.dentist_id
JOIN Patient ON Appointment.patient_id = Patient.patient_id
WHERE Appointment.location_id = 4;

-- List of Appointments booked for a Patient on a specific Date:

SELECT Appointment.*, Dentist.first_name AS dentist_first_name, Dentist.last_name AS dentist_last_name
FROM Appointment
JOIN Dentist ON Appointment.dentist_id = Dentist.dentist_id
WHERE Appointment.patient_id = 2 AND Appointment.appointment_date = "2024-11-10";

