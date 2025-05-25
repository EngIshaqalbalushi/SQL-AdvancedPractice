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


--Part 2:
--4. Try DELETE FROM Trainees WHERE Program = 'Outsystems'.

DELETE FROM Trainees WHERE Program = 'Outsystems';

--5. Try TRUNCATE TABLE Applicants.

TRUNCATE TABLE Applicants;

--6. Try DROP TABLE Applicants.

drop table Applicants

---Part 3

--Part 3: Self-Discovery & Applied Exploration

--Task
SELECT TraineeID, FullName, Email, Program, GraduationDate
FROM Trainees
WHERE Email IN (
    SELECT Email
    FROM Applicants
);

--Extra Challenge

--Wrote a query to find all trainees whose emalis appear in the applicants table

UPDATE Applicants
SET Source = 'Trainee Referral'
WHERE Email IN (
    SELECT Email 
    FROM Trainees
    WHERE GraduationDate > '2025-01-01'
);











