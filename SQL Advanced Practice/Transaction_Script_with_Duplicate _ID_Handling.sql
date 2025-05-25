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


--Batch Script & Transactions

 --Write a script that SQL transaction

BEGIN TRY
    -- Start transaction
    BEGIN TRANSACTION;
    
    -- First valid insert
    INSERT INTO Applicants (ApplicantID, FullName, Email, Source, AppliedDate)
    VALUES (104, 'Mohammed Al Abri', 'mohammed.a@example.com', 'Website', '2025-05-10');
    
    -- Second insert with duplicate ID (will fail)
    INSERT INTO Applicants (ApplicantID, FullName, Email, Source, AppliedDate)
    VALUES (102, 'Fatima Al Nasser', 'fatima.n@example.com', 'Referral', '2025-05-11');
    
    -- If we reach here, commit all changes
    COMMIT TRANSACTION;
   -- PRINT 'Transaction committed successfully';
END TRY
BEGIN CATCH
    -- Error occurred, rollback everything
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back due to error: ' + ERROR_MESSAGE();
    
    -- Show specific error details
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- Verify results
SELECT * FROM Applicants WHERE ApplicantID IN (102, 104);




--Transaction Script with Duplicate ID Handling

BEGIN TRY
    -- Start the transaction
    BEGIN TRANSACTION;
    
    -- First valid insert
    INSERT INTO Applicants (ApplicantID, FullName, Email, Source, AppliedDate)
    VALUES (104, 'Zahra Al Amri', 'zahra.a@example.com', 'Referral', '2025-05-10');
    
    -- Second insert with duplicate ID (will cause failure)
    INSERT INTO Applicants (ApplicantID, FullName, Email, Source, AppliedDate)
    VALUES (104, 'Error User', 'error@example.com', 'Website', '2025-05-11');
    
    -- If we reach here, commit the transaction
    COMMIT TRANSACTION;
    PRINT 'Both inserts were successful - transaction committed';
END TRY
BEGIN CATCH
    -- Error occurred, rollback everything
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    -- Display error information
    PRINT 'Transaction rolled back due to error:';
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    
    -- More detailed error information
    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine;
END CATCH;

-- Verify no records were inserted
SELECT * FROM Applicants WHERE ApplicantID = 104;