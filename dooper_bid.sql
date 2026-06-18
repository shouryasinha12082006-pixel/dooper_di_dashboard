CREATE DATABASE dooper_bid;
USE dooper_bid;

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender ENUM('Male','Female','Other'),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    registration_date DATE
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100),
    service_cost DECIMAL(10,2)
);

INSERT INTO services(service_name, service_cost)
VALUES
('Doctor Consultation',500),
('Blood Test',800),
('Home Nursing',1500),
('Physiotherapy',1200),
('ECG',700);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    service_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status ENUM('Completed','Pending','Cancelled'),

    FOREIGN KEY(patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY(service_id) REFERENCES services(service_id)
);

CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    amount DECIMAL(10,2),
    payment_status ENUM('Paid','Unpaid'),
    payment_date DATE,

    FOREIGN KEY(appointment_id)
    REFERENCES appointments(appointment_id)
);

CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE,

    FOREIGN KEY(patient_id)
    REFERENCES patients(patient_id)
);

INSERT INTO doctors
(doctor_name,specialization,phone,email)
VALUES
('Dr. Sharma','Cardiology','9876543210','sharma@dooper.com'),
('Dr. Gupta','General Medicine','9876543211','gupta@dooper.com'),
('Dr. Singh','Physiotherapy','9876543212','singh@dooper.com');

INSERT INTO patients
(first_name,last_name,age,gender,phone,email,address,registration_date)
VALUES
('Rahul','Kumar',25,'Male','9876500001','rahul@gmail.com','Delhi','2026-01-10'),
('Priya','Sharma',32,'Female','9876500002','priya@gmail.com','Mumbai','2026-02-15'),
('Amit','Verma',40,'Male','9876500003','amit@gmail.com','Pune','2026-03-20');

INSERT INTO appointments
(patient_id,doctor_id,service_id,appointment_date,appointment_time,status)
VALUES
(1,1,1,'2026-06-01','10:00:00','Completed'),
(2,2,2,'2026-06-05','11:30:00','Completed'),
(3,3,4,'2026-06-10','14:00:00','Pending');

INSERT INTO billing
(appointment_id,amount,payment_status,payment_date)
VALUES
(1,500,'Paid','2026-06-01'),
(2,800,'Paid','2026-06-05'),
(3,1200,'Unpaid',NULL);

SELECT COUNT(*) AS total_patients
FROM patients;

SELECT COUNT(*) AS total_appointments
FROM appointments;

SELECT COUNT(*) AS completed
FROM appointments
WHERE status='Completed';

SELECT SUM(amount) AS total_revenue
FROM billing
WHERE payment_status='Paid';

SELECT s.service_name,
       COUNT(*) AS total_bookings
FROM appointments a
JOIN services s
ON a.service_id=s.service_id
GROUP BY s.service_name
ORDER BY total_bookings DESC;

SELECT MONTH(registration_date) AS month,
       COUNT(*) AS patients
FROM patients
GROUP BY MONTH(registration_date);

SELECT status,
       COUNT(*) AS count
FROM appointments
GROUP BY status;