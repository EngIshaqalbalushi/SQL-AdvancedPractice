

-- Employees Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary INT,
    DeptID INT
)

INSERT INTO Employees (EmpID, Name, Salary, DeptID)
VALUES
    (1, 'Alice', 60000, 101),
    (2, 'Bob', 45000, 102),
    (3, 'Charlie', 75000, 101),
    (4, 'Diana', 50000, 103),
    (5, 'Eve', 68000, 102);
-- Departments Table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100)
);
INSERT INTO Departments (DeptID, DeptName, Location)
VALUES
    (101, 'Engineering', 'New York'),
    (102, 'Sales', 'Chicago'),
	    (103, 'HR', 'San Francisco');


CREATE VIEW HighEarners AS
SELECT Name, Salary
FROM Employees
WHERE Salary > 60000;
--2. Create View `EmpDepartmentInfo`:
CREATE VIEW EmpDepartmentInfo AS
SELECT E.Name, E.Salary, D.DeptName, D.Location
FROM Employees E
JOIN Departments D ON E.DeptID = D.DeptID;
--3. Create View `ChicagoEmployees`:
CREATE VIEW ChicagoEmployees AS
SELECT E.*
FROM Employees E
JOIN Departments D ON E.DeptID = D.DeptID
WHERE D.Location = 'Chicago';
--4. Update View `HighEarners` to include DeptID:
CREATE OR REPLACE VIEW HighEarners AS
SELECT Name, Salary, DeptID
FROM Employees
WHERE Salary > 60000;
--5. Try to Update Salary Through View:
-- Example:
UPDATE HighEarners
SET Salary = 70000
WHERE Name = 'Eve';

