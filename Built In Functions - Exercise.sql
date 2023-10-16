--Lab Tasks 

--Obfuscate CC Numbers
USE [Demo];

CREATE VIEW v_PublicPaymentInfo AS SELECT 
CustomerID,
FirstName,
LastName,
CONCAT(LEFT (PaymentNumber, 6), REPLICATE('*', LEN(PaymentNumber) - 6)) AS PaymentNumber
FROM [Customers];

SELECT * FROM v_PublicPaymentInfo;


--Pallets
SELECT * FROM Products;

SELECT 
CEILING(CEILING(Quantity * 1.0 / BoxCapacity) / PalletCapacity * 1.0) AS [Number of pallets]
FROM Products;

--Quarterly Report
SELECT
InvoiceId,
Total,
DATEPART(QUARTER, InvoiceDate) AS [Quarter],
DATEPART(MONTH, InvoiceDate) AS [Month],
DATEPART(YEAR, InvoiceDate) AS [Year],
DATEPART(DAY, InvoiceDate) AS [Day]
FROM Invoices;

--Exercise Tasks

--Task 01

USE SoftUni;

SELECT
FirstName,
LastName
FROM Employees
WHERE FirstName LIKE 'Sa%';


--Task 02
SELECT
FirstName,
LastName
FROM Employees
WHERE LastName LIKE '%ei%';

--Task 03
SELECT
FirstName
FROM Employees
WHERE DepartmentID IN (3,10) AND
DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005; 


--Task 04
SELECT
FirstName,
LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%';

--Task 05
SELECT
[Name]
FROM Towns
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name];

--Task 06
SELECT
*
FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name];

--Task 07
SELECT
*
FROM Towns
WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name];

--Task 08

CREATE VIEW V_EmployeesHiredAfter2000 AS 
SELECT
FirstName,
LastName
FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000;

--Task 09
SELECT
FirstName,
LastName
FROM Employees
WHERE LEN(LastName) = 5;


--Task 10
SELECT
EmployeeID,
FirstName,
LastName,
Salary,
DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC;


--Task 11
SELECT * FROM
	(
	SELECT
	EmployeeID,
	FirstName,
	LastName,
	Salary,
	DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	) AS [Subquery]
WHERE [Subquery].[Rank] = 2
ORDER BY Salary DESC;

--Task 12
USE [Geography];

SELECT [CountryName], [ISOCode]
FROM Countries
WHERE LEN(REPLACE(LOWER([CountryName]), 'a', '')) <= LEN([CountryName]) - 3
ORDER BY [ISOCode];

SELECT [CountryName], [ISOCode]
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY [ISOCode];


--Task 13
SELECT 
PeakName,
RiverName,
LOWER(CONCAT( PeakName, SUBSTRING(RiverName, 2, LEN(RiverName) - 1))) AS Mix
FROM Rivers AS r, Peaks AS p
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix;

--Task 14
USE Diablo;

SELECT TOP 50
[Name],
FORMAT([Start], 'yyyy-MM-dd') AS [Start]
FROM Games
WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012
ORDER BY [Start], [Name];


--Task 15

SELECT
[Username],
SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email])) AS [Email Provider]
FROM Users
ORDER BY [Email Provider], Username;

--Task 16
SELECT
[Username],
[IpAddress]
FROM [Users]
WHERE [IpAddress] LIKE '___.1%.%.___'
ORDER BY [Username];


--Task 17

SELECT
[Name] AS [Game],
CASE
	WHEN DATEPART(HOUR,[Start]) BETWEEN 0 AND 11 THEN 'Morning'
	WHEN DATEPART(HOUR,[Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
	WHEN DATEPART(HOUR,[Start]) BETWEEN 18 AND 23 THEN 'Evening'
END AS [Part of the Day],
CASE 
	WHEN [Duration] <= 3 THEN 'Extra Short'
	WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
	WHEN [Duration] > 6 THEN 'Long'
	ELSE 'Extra Long'
END AS [Duration]
FROM [Games]
ORDER BY [Name], [Duration], [Part of the Day];

--Task 18
USE Orders;

SELECT
[ProductName],
[OrderDate],
DATEADD(DAY, 3, [OrderDate]) AS [Pay Due],
DATEADD(MONTH, 1, [OrderDate]) AS [Deliver Due]
FROM Orders;
