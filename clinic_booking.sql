#Create database
CREATE DATABASE clinic_booking;

#use database to insert clinic data
 USE clinic_booking;
 
 -- Table: Departments
CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Doctors
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    email VARCHAR(100) NOT NULL UNIQUE,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Table: Patients
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Table: Appointments
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- Sample Data
INSERT INTO departments (name) VALUES ('Cardiology'), ('Dermatology');

INSERT INTO doctors (name, department_id, email)
VALUES ('Dr. Alice Smith', 1, 'alice@clinic.com'), ('Dr. Bob Jones', 2, 'bob@clinic.com');

INSERT INTO patients (name, date_of_birth, email)
VALUES ('John Doe', '1990-05-10', 'john@gmail.com'), ('Jane Roe', '1985-07-21', 'jane@yahoo.com');

INSERT INTO appointments (doctor_id, patient_id, appointment_date, reason)
VALUES (1, 1, '2025-05-10 09:00:00', 'Chest pain'),
       (2, 2, '2025-05-11 14:00:00', 'Skin rash');