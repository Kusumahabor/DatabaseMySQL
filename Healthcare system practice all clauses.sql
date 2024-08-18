CREATE DATABASE HealthcareSystemDB;
USE HealthcareSystemDB;

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(150) NOT NULL UNIQUE,
    City VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(150) NOT NULL,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Canceled') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    MedicineName VARCHAR(150) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Diagnosis TEXT,
    Treatment TEXT,
    RecordDate DATETIME NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(150) NOT NULL UNIQUE,
    HeadDoctorID INT,
    FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AppointmentID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    PaidAmount DECIMAL(10, 2) NOT NULL,
    BalanceAmount DECIMAL(10, 2) NOT NULL,
    PaymentStatus ENUM('Paid', 'Unpaid', 'Partial') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert Expanded Sample Data
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, City, Country) VALUES
('John', 'Doe', '1980-01-15', 'Male', '123-456-7890', 'john.doe@example.com', 'New York', 'USA'),
('Jane', 'Smith', '1985-05-20', 'Female', '123-555-7890', 'jane.smith@example.com', 'Los Angeles', 'USA'),
('Alice', 'Johnson', '1990-03-25', 'Female', '555-123-7890', 'alice.j@example.com', 'Chicago', 'USA'),
('Bob', 'Brown', '1975-11-30', 'Male', '555-987-6543', 'bob.b@example.com', 'Miami', 'USA'),
('Eve', 'Davis', '1988-07-15', 'Female', '555-654-3210', 'eve.d@example.com', 'Houston', 'USA'),
('Charlie', 'Miller', '1992-09-05', 'Male', '555-321-6548', 'charlie.m@example.com', 'Seattle', 'USA'),
('David', 'Wilson', '1982-04-20', 'Male', '555-789-4561', 'david.w@example.com', 'San Francisco', 'USA'),
('Fiona', 'Taylor', '1987-12-10', 'Female', '555-456-7893', 'fiona.t@example.com', 'Denver', 'USA'),
('Grace', 'Martinez', '1995-02-17', 'Female', '555-123-9876', 'grace.m@example.com', 'Austin', 'USA');

INSERT INTO Doctors (FirstName, LastName, Specialization, PhoneNumber, Email) VALUES
('Gregory', 'House', 'Diagnostic Medicine', '555-678-1234', 'house.g@example.com'),
('Meredith', 'Grey', 'General Surgery', '555-987-6543', 'grey.m@example.com'),
('John', 'Watson', 'Internal Medicine', '555-321-7654', 'watson.j@example.com'),
('Amelia', 'Shepherd', 'Neurosurgery', '555-987-3214', 'shepherd.a@example.com'),
('Derek', 'Shepherd', 'Cardiology', '555-654-9874', 'shepherd.d@example.com'),
('Miranda', 'Bailey', 'Pediatrics', '555-123-6548', 'bailey.m@example.com');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason, Status) VALUES
(1, 1, '2023-07-01 10:00:00', 'Routine Checkup', 'Completed'),
(2, 2, '2023-07-02 14:00:00', 'Surgery Consultation', 'Scheduled'),
(3, 3, '2023-07-03 16:00:00', 'Follow-up Visit', 'Completed'),
(4, 4, '2023-07-04 09:00:00', 'Neurosurgery Consultation', 'Scheduled'),
(5, 5, '2023-07-05 11:00:00', 'Cardiology Consultation', 'Completed'),
(6, 6, '2023-07-06 08:00:00', 'Pediatric Checkup', 'Completed'),
(7, 1, '2023-07-07 10:00:00', 'Routine Checkup', 'Scheduled'),
(8, 2, '2023-07-08 12:00:00', 'Surgery Follow-up', 'Completed'),
(9, 3, '2023-07-09 15:00:00', 'Internal Medicine Consultation', 'Canceled');

INSERT INTO Prescriptions (AppointmentID, MedicineName, Dosage, Duration) VALUES
(1, 'Ibuprofen', '200mg', '7 days'),
(3, 'Paracetamol', '500mg', '5 days'),
(5, 'Aspirin', '100mg', '10 days'),
(6, 'Amoxicillin', '250mg', '7 days'),
(8, 'Ciprofloxacin', '500mg', '5 days'),
(9, 'Metformin', '500mg', '30 days');

INSERT INTO MedicalRecords (PatientID, DoctorID, Diagnosis, Treatment, RecordDate) VALUES
(1, 1, 'Hypertension', 'Lifestyle modification', '2023-07-01 10:30:00'),
(3, 3, 'Common Cold', 'Rest and hydration', '2023-07-03 16:30:00'),
(5, 5, 'Heart Disease', 'Medication and lifestyle changes', '2023-07-05 11:30:00'),
(6, 6, 'Asthma', 'Inhaler and medication', '2023-07-06 08:30:00'),
(7, 1, 'Diabetes', 'Insulin and diet management', '2023-07-07 10:30:00'),
(9, 3, 'Thyroid Disorder', 'Medication', '2023-07-09 15:30:00');

INSERT INTO Departments (DepartmentName, HeadDoctorID) VALUES
('Cardiology', 5),
('Surgery', 2),
('Internal Medicine', 3),
('Neurosurgery', 4),
('Pediatrics', 6),
('Diagnostic Medicine', 1);

INSERT INTO Billing (PatientID, AppointmentID, TotalAmount, PaidAmount, BalanceAmount, PaymentStatus) VALUES
(1, 1, 200.00, 200.00, 0.00, 'Paid'),
(2, 2, 1500.00, 500.00, 1000.00, 'Partial'),
(3, 3, 100.00, 100.00, 0.00, 'Paid'),
(4, 4, 3000.00, 0.00, 3000.00, 'Unpaid'),
(5, 5, 500.00, 500.00, 0.00, 'Paid'),
(6, 6, 250.00, 250.00, 0.00, 'Paid'),
(7, 7, 200.00, 100.00, 100.00, 'Partial'),
(8, 8, 1500.00, 1500.00, 0.00, 'Paid'),
(9, 9, 100.00, 0.00, 100.00, 'Unpaid');


#Ticket 1

show tables;

#Ticket 2

Select * from patients where Gender = 'Female';

select * from Appointments
 where status = 'Scheduled';
 
 select * from Doctors where Specialization='Internal Medicine';
 
 select * from Patients
 where DateOfBirth > '1985-01-01';
 
 select * from MedicalRecords
 where Diagnosis like '%cold';
 
 #Ticket 3
 
 select * from Patients order by LastName;
 
 select * from Doctors order by Specialization desc;
 
 select * from Appointments order by AppointmentDate desc;
 
 select * from Departments order by DepartmentName;
 
 select * from Billing order by BalanceAmount desc;
 
 #Ticket 4
 
 select country, count(*) from Patients group by Country;
 
 select doctorid, count(doctorid) as Doctor from Appointments group by DoctorID;
 
 select * from Billing;
 select PatientID,sum(TotalAmount) from Billing group by PatientID;
 
 select * from Appointments;
 select DoctorID,count(*) as NoOfAppointments from Appointments where status='Scheduled'
 group by DoctorID having NoOfAppointments>1;  
 
 #Ticket 5
 
 select * from Patients where FirstName like 'j%';
 
 select * from Doctors where lastname like '%son';
 
 select * from Departments where DepartmentName like '%y';
 
 select * from MedicalRecords where Diagnosis like '%Hypertension%';
 
 select * from Patients where email like '%@ample.com';
 
 select * from appointments where appointmentdate between '2023-07-01' and '2023-07-03';
 
 select * from Patients where DateOfBirth between '1980-01-01' and '1990-12-31';
 
 desc Billing;
 select * from Billing where totalamount between 100 and 500;
 
 select * from appointments where AppointmentDate between '2023-07-01' and '2023-07-08';
 
 # Ticket 7
 
 select * from Patients order by LastName limit 5;
 
 select * from Billing order by TotalAmount desc limit 3; 
 
 select * from Appointments order by AppointmentDate limit 10;
 
 select * from Doctors order by FirstName limit 5;
 
 select * from Billing order by BalanceAmount desc limit 5;
 
 #Ticket 8
 
 select * from patients where gender='Female' and country='USA' 
 order by lastname limit 3;
 
 select * from Doctors;
 select doctorid,count(*) as NoOfAppointment from appointments
 where status='Scheduled' 
 group by doctorid having NoOfAppointment>=1
 order by NoOfAppointment desc;
 
 select * from patients where lastname like 's%' and dateofbirth > '1985-01-01'
 order by dateofbirth;
 

 SELECT b.PatientID, SUM(b.TotalAmount) AS TotalBilledAmount FROM Billing b
JOIN Appointments a ON b.AppointmentID = a.AppointmentID
GROUP BY b.PatientID HAVING SUM(b.TotalAmount) BETWEEN 200 AND 1500
    AND COUNT(a.status) > 1;
    
select * from Appointments;

 
 
 
 
 


