create database TrainingAndJobApplicationSystem

CREATE TABLE Trainees (
 TraineeID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 Program VARCHAR(50),
 GraduationDate DATE
);

CREATE TABLE Applicants (
 ApplicantID INT PRIMARY KEY,
 FullName VARCHAR(100),
 Email VARCHAR(100),
 Source VARCHAR(20), -- e.g., "Website", "Referral"
 AppliedDate DATE
);

INSERT INTO Trainees VALUES
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'),
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'),
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01');

INSERT INTO Applicants VALUES
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'),
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'), 
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');

--Part 1:
--1. List all unique people who either trained or applied for a job.

SELECT FullName, Email
FROM Trainees

UNION  

SELECT FullName, Email
FROM Applicants;


--2. Now use UNION ALL. What changes in the result?


SELECT FullName, Email
FROM Trainees
UNION ALL 
SELECT FullName, Email
FROM Applicants;

--3. Find people who are in both tables.


SELECT FullName, Email
FROM Trainees

INTERSECT

SELECT FullName, Email
FROM Applicants;




