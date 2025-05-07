CREATE  Database clinical;
USE clinical;
CREATE TABLE Speciality(
    SpecialtyID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Medical specialty name',
    Description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Clinic Locations
CREATE TABLE Clinic (
    ClinicID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    UNIQUE (Name, Address)  -- Prevent duplicate clinic entries
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Patient Registry
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Medical Professionals
CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    LicenseNumber VARCHAR(20) UNIQUE NOT NULL COMMENT 'Medical license ID',
    ClinicID INT NOT NULL,
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Doctor Specialization Mapping
CREATE TABLE DoctorSpecialty (
    DoctorID INT NOT NULL,
    SpecialtyID INT NOT NULL,
    PRIMARY KEY (DoctorID, SpecialtyID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (SpecialtyID) REFERENCES Specialties(SpecialtyID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Appointment Management
CREATE TABLE Appointment(
  AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
  PatientID INT NOT NULL,
  DoctorID INT NOT NULL,
  DateTime DATETIME NOT NULL,
  Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
  Notes TEXT,
  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
  FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
  INDEX (DateTime)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/* ======================= OPTIONAL DATA ======================= */
-- Sample Clinics
INSERT INTO Clinics (Name, Address, Phone) VALUES
('City Medical Center', '123 Health Lane', '555-1234'),
('Downtown Clinic', '456 Care Street', '555-5678');

-- Medical Specialties
INSERT INTO Specialties (Name) VALUES
('General Practice'),
('Cardiology'),
('Pediatrics'),
('Dermatology');

-- Sample Doctors
INSERT INTO Doctors (FirstName, LastName, LicenseNumber, ClinicID) VALUES
('Sarah', 'Wilson', 'MD-1234', 1),
('Michael', 'Chen', 'MD-6789', 2);
