--Task 02
SELECT * FROM [Departments];

--Task 03
SELECT [Name] FROM [Departments];

--Task 04
SELECT [FirstName], [LastName], [Salary] FROM [Employees];

--Task 05
SELECT [FirstName], [MiddleName], [LastName] FROM [Employees];

--Task 06
SELECT [FirstName] + '.' +[LastName] + '@softuni.bg' AS [Full Email Address] FROM [Employees];

--Task 07
SELECT DISTINCT [Salary] FROM [Employees];

--Task 08
SELECT * FROM [Employees]
WHERE [JobTitle] = 'Sales Representative';

--Task 09
SELECT [FirstName], [LastName], [JobTitle] FROM [Employees]
WHERE [Salary] BETWEEN 20000 AND 30000;

--Task 10
SELECT [FirstName]+ ' '+ [MiddleName] + ' ' + [LastName] AS [Full Name] FROM [Employees]
WHERE [Salary] = 25000 OR [Salary] = 14000 OR [Salary] = 12500 OR [Salary] = 23600;

--Task 11
SELECT [FirstName], [LastName] FROM [Employees]
WHERE [ManagerID] IS NULL;

--Task 12
SELECT [FirstName], [LastName], [Salary] FROM [Employees]
WHERE [Salary] > 50000
ORDER BY [Salary] DESC;

--Task 13
SELECT TOP(5) [FirstName], [LastName] FROM [Employees]
ORDER BY [Salary] DESC;
 
 --Task 14
 SELECT [FirstName], [LastName] FROM [Employees]
 WHERE [DepartmentID] <> 4;

 --Task 15
 SELECT * FROM [Employees]
 ORDER BY [Salary] DESC, [FirstName], [LastName] DESC , [MiddleName];

 --Task 16
 CREATE VIEW v_EmployeesSalaries
 AS SELECT [FirstName], [LastName], [Salary] FROM [Employees];

--Task 17
CREATE VIEW V_EmployeeNameJobTitle
AS SELECT CONCAT([FirstName],' ' ,[MiddleName],' ',[LastName]) AS [Full Name], [JobTitle] AS [Job Title] FROM [Employees];
SELECT * FROM V_EmployeeNameJobTitle;

--Task 18
SELECT DISTINCT [JobTitle] FROM [Employees];

--Task 19
SELECT TOP(10) * FROM [Projects]
WHERE [StartDate] IS NOT NULL
ORDER BY [StartDate], [Name];


--Task 20
SELECT TOP(7) [FirstName], [LastName], [HireDate] FROM [Employees]
ORDER BY [HireDate] DESC;


--Task 21
SELECT [Salary] FROM Employees
WHERE DepartmentID IN 
(SELECT DepartmentID FROM Departments WHERE [Name] IN 
('Engineering','Tool Design','Marketing','Information Services'));


--Task 22
USE Geography;

SELECT [PeakName] FROM [Peaks]
ORDER BY [PeakName];


--Task 23
SELECT TOP(30) [CountryName], [Population] FROM [Countries]
WHERE [ContinentCode] = 'EU'
ORDER BY [Population] DESC, [CountryName];


--Task 24
SELECT [CountryName], [CountryCode],
CASE [CurrencyCode] WHEN 'EUR' THEN 'Euro' 
ELSE 'Not Euro' END AS [Currency]
FROM [Countries]
ORDER BY [CountryName];


--Task 25
USE [Diablo];

SELECT [Name] FROM [Characters]
ORDER BY [Name];


--Table Relations Lab
USE [Geography];

SELECT m.[MountainRange],[PeakName], [Elevation] FROM [Mountains] AS m
JOIN [Peaks] AS p ON p.[MountainId] = m.[Id]
WHERE m.MountainRange = 'Rila'
ORDER BY p.[Elevation] DESC;