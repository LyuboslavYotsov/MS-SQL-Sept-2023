--Task 01
SELECT
COUNT(*)
FROM WizzardDeposits;


--Task 02
SELECT
MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits;

--Task 03
SELECT
DepositGroup,
MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup;

--Task 04
SELECT
TOP(2)
DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize);

--Task 05
SELECT
DepositGroup,
SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup;

--Task 06
SELECT
DepositGroup,
SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup;

--Task 07
SELECT
DepositGroup,
SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup HAVING SUM(DepositAmount) < 150000
ORDER BY SUM(DepositAmount) DESC;

--Task 08
SELECT
DepositGroup,
MagicWandCreator,
MIN(DepositCharge)
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup;

--Task 09
SELECT 
GroupData.AgeGroup,
COUNT(*) AS WizardCount
FROM
	(SELECT
		CASE
			WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			ELSE '[61+]'
		END AS AgeGroup
	FROM WizzardDeposits) AS GroupData
GROUP BY GroupData.AgeGroup;

--Task 10
SELECT
SUBSTRING(FirstName, 1, 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY SUBSTRING(FirstName, 1, 1)
ORDER BY FirstLetter;

--Task 11
SELECT
dt.DepositGroup,
dt.IsDepositExpired,
AVG(dt.DepositInterest)
FROM
	(SELECT
	DepositGroup,
	IsDepositExpired,
	DepositInterest
	FROM WizzardDeposits
	WHERE DepositStartDate > '1985-01-01') AS dt
GROUP BY dt.DepositGroup, dt.IsDepositExpired
ORDER BY dt.DepositGroup DESC, dt.IsDepositExpired;

--Task 12* LEAD() AND PARTITTION

--Task 13
USE SoftUni;

SELECT
DepartmentID,
SUM(Salary)
FROM Employees
GROUP BY DepartmentID;

--Task 14
SELECT
DepartmentID,
MIN(Salary)
FROM Employees
WHERE DepartmentID IN (2,5,7) AND HireDate > '2000-01-01'
GROUP BY DepartmentID;

--Task 15
SELECT
*
INTO Employees2
FROM Employees
WHERE Salary > 30000;

DELETE FROM Employees2
WHERE ManagerID = 42;

UPDATE Employees2
SET Salary += 5000
WHERE DepartmentID = 1

SELECT
DepartmentID,
AVG(Salary) AS AverageSalary
FROM Employees2
GROUP BY DepartmentID

DROP TABLE Employees2;

--Task 16
SELECT
DepartmentID,
MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000;

--Task 17
SELECT
COUNT(*)
FROM Employees
WHERE ManagerID IS NULL;
