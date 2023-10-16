--Task 01
SELECT
TOP 5
e.EmployeeID,
e.JobTitle,
e.AddressID,
a.AddressText
FROM [Employees] AS e
JOIN [Addresses] AS a ON a.AddressID = e.AddressID
ORDER BY e.AddressID;


--Task 02
SELECT
TOP 50
[FirstName],
[LastName],
t.[Name] AS [Town],
a.AddressText AS [AddressText]
FROM [Employees] as e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY e.FirstName, e.LastName;

--Task 03
SELECT
[EmployeeID],
[FirstName],
[LastName],
d.[Name] AS [DepartmentName]
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID AND d.[Name] = 'Sales'
ORDER BY e.[EmployeeID];

--Task 04
SELECT
TOP(5)
e.EmployeeID,
e.FirstName,
e.Salary,
d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID;

--Task 05
SELECT 
TOP(3)
e.EmployeeID,
e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
LEFT JOIN Projects AS p ON p.ProjectID = ep.ProjectID
WHERE ep.EmployeeID IS NULL;


--Task 06
SELECT
e.FirstName,
e.LastName,
e.HireDate,
d.[Name] AS DeptName
FROM Employees as e
JOIN Departments as d ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1999-1-1' AND d.Name IN ('Sales' , 'Finance')
ORDER BY e.HireDate;

--Task 07
SELECT
TOP(5)
e.EmployeeID,
e.FirstName,
p.[Name] AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID;


--Task 08
SELECT
e.EmployeeID,
e.FirstName,
	CASE
		WHEN p.StartDate > '2004-12-31' THEN NULL
		ELSE p.Name
	END AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID AND e.EmployeeID = 24
JOIN Projects AS p ON p.ProjectID = ep.ProjectID;

--Task 09
SELECT
e.EmployeeID,
e.FirstName,
e.ManagerID,
m.FirstName
FROM Employees AS e
JOIN Employees AS m ON m.EmployeeID = e.ManagerID AND m.EmployeeID IN (3,7)
ORDER BY e.EmployeeID;

--Task 10
SELECT
TOP 50
e.[EmployeeID],
CONCAT_WS(' ', e.FirstName, e.LastName) AS EmployeeName,
CONCAT_WS(' ', m.FirstName, m.LastName) AS ManagerName,
d.[Name] AS [DepartmentName]
FROM Employees as e
LEFT JOIN Employees as m ON e.ManagerID = m.EmployeeID
LEFT JOIN Departments as d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID;

--Task 11

SELECT MIN(a.AverageSalary)
FROM
(SELECT 
AVG(e.Salary) AS AverageSalary
FROM Employees AS e
GROUP BY e.DepartmentID) as a;


--Task 12
USE [Geography];
SELECT
c.CountryCode,
m.MountainRange,
p.PeakName,
p.Elevation
FROM Countries as c
JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
JOIN Mountains as m ON m.Id = mc.MountainId
JOIN Peaks AS p ON p.MountainId = m.Id
WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC;


--Task 13
SELECT
c.CountryCode,
COUNT(m.MountainRange)
FROM Countries AS c
JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
JOIN Mountains as m ON m.Id = mc.MountainId
WHERE c.CountryCode IN ('US','RU','BG')
GROUP BY c.CountryCode;

--Task 14
SELECT
TOP(5)
c.CountryName,
r.RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers as r ON r.Id = cr.RiverId
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName;

--Task 15
SELECT
ContinentCode,
CurrencyCode,
CurrencyUsage
FROM
	(SELECT
	*,
	DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY CurrencyUsage DESC) AS CurrencyRank
	FROM
		(SELECT
		ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS CurrencyUsage
		FROM Countries
		GROUP BY ContinentCode, CurrencyCode HAVING COUNT(CurrencyCode) > 1) AS dt1) AS dt2
WHERE CurrencyRank = 1
ORDER BY ContinentCode;


--Task 16
SELECT
COUNT(*) AS [Count]
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
LEFT JOIN Mountains as m ON m.Id = mc.MountainId
WHERE m.MountainRange IS NULL;

--Task 17
SELECT
TOP(5)
pd.CountryName,
MAX(pd.Elevation) AS HighestPeakElevation,
MAX(pd.[Length]) AS LongestRiverLength
FROM
	(SELECT
	c.CountryName,
	p.Elevation,
	r.[Length]
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains as m ON m.Id = mc.MountainId
	JOIN Peaks AS p ON p.MountainId = m.Id
	LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
	JOIN Rivers as r ON r.Id = cr.RiverId) AS pd
GROUP BY pd.CountryName
ORDER BY MAX(pd.Elevation) DESC, MAX(pd.[Length])DESC , pd.CountryName;

--Task 18
SELECT
TOP(5)
rankdt.CountryName AS Country,
	CASE	
		WHEN rankdt.PeakName IS NULL THEN '(no highest peak)'
		ELSE rankdt.PeakName
	END AS [Highest Peak Name],

	CASE 
		WHEN rankdt.Elevation IS NULL THEN 0
		ELSE rankdt.Elevation
	END AS [Highest Peak Elevation],

	CASE
		WHEN rankdt.MountainRange IS NULL THEN '(no mountain)'
		ELSE rankdt.MountainRange
	END AS [Mountain]
FROM
	(SELECT
	c.CountryName,
	p.PeakName,
	p.Elevation,
	m.MountainRange,
	DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS PeakRank
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Mountains as m ON m.Id = mc.MountainId
	LEFT JOIN Peaks AS p ON p.MountainId = m.Id) AS rankdt
WHERE rankdt.PeakRank = 1
ORDER BY rankdt.CountryName, [Highest Peak Name]