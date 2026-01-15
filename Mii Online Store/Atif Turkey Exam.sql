-- Reset old tables
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;


CREATE TABLE Doctors(
  DoctorID INT PRIMARY KEY,
  DoctorName VARCHAR(20),
  Specialization VARCHAR(20),
  Fee INT
);

CREATE TABLE Patients(
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(20) NOT NULL,
    City VARCHAR(20) NOT NULL
);

CREATE TABLE Appointments(
    AppointmentID INT PRIMARY KEY,
    DoctorID INT,
    PatientID INT,
    VisitDate DATE,
    FeeCharged INT
);


INSERT INTO Doctors(DoctorID, DoctorName, Specialization, Fee)
VALUES
(1, 'Dr. Ali Khan', 'Cardiologist', 1500),
(2, 'Dr. Sara Ahmed', 'Dermatologist', 1000),
(3, 'Dr. Imran Qureshi', 'Neurologist', 1800),
(4, 'Dr. Nadia Zafar', 'Dentist', 1200);

INSERT INTO Patients(PatientID, PatientName, City)
VALUES
(101, 'Ahmed Raza', 'Lahore'),
(102, 'Fatima Noor', 'Karachi'),
(103, 'Bilal Ahmed', 'Lahore'),
(104, 'Sana Malik', 'Islamabad');

INSERT INTO Appointments(AppointmentID, DoctorID, PatientID, VisitDate, FeeCharged)
VALUES
(201, 1, 101, '2024-01-12', 1600),
(202, 2, 102, '2024-02-15', 900),
(203, 3, 103, '2024-03-10', 1800),
(204, 4, 104, '2024-04-20', 1300),
(205, 1, 101, '2024-05-25', 1400),
(206, 3, 103, '2024-06-18', 1900);



ALTER TABLE Appointments
ADD CONSTRAINT fk_doctor
FOREIGN KEY (DoctorID)
REFERENCES Doctors(DoctorID)
ON DELETE CASCADE;

ALTER TABLE Appointments
ADD CONSTRAINT fk_patient
FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID);


INSERT INTO Patients(PatientID, PatientName, City)
VALUES (105, 'Muhammad Atif', 'Islamabad');


UPDATE Doctors
SET Fee = Fee * 1.10
WHERE Specialization = 'Dentist';


SELECT 
    d.DoctorName,
    COUNT(a.AppointmentID) AS TotalAppointments,
    SUM(a.FeeCharged) AS TotalAmountEarned
FROM Doctors d
JOIN Appointments a
    ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorName
HAVING COUNT(a.AppointmentID) > 0;


SELECT 
    d.DoctorID,
    COALESCE(SUM(a.FeeCharged), 0) AS TotalEarnings
FROM Doctors d
LEFT JOIN Appointments a
    ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID;


SELECT 
    A1.AppointmentID AS AppointmentID1,
    A2.AppointmentID AS AppointmentID2,
    A1.DoctorID,
    A1.FeeCharged AS Fee1,
    A2.FeeCharged AS Fee2
FROM Appointments A1
JOIN Appointments A2
    ON A1.DoctorID = A2.DoctorID
    AND A1.AppointmentID < A2.AppointmentID
    AND A1.FeeCharged > A2.FeeCharged;


SELECT 
    p.PatientName,
    d.DoctorName,
    a.VisitDate
FROM Appointments a
JOIN Patients p
    ON a.PatientID = p.PatientID
JOIN Doctors d
    ON a.DoctorID = d.DoctorID
WHERE p.City = 'Lahore'
  AND d.Fee > 1400;
