--Task 05
SELECT
	r.[Description],
	FORMAT(r.OpenDate, 'dd-MM-yyyy') AS OpenDate
FROM Reports AS r
WHERE EmployeeId IS NULL
ORDER BY r.OpenDate, [Description];

--Task 06

SELECT
	r.[Description],
	c.[Name]
FROM Reports AS r
	JOIN Categories AS c ON c.Id = r.CategoryId
ORDER BY r.[Description], c.[Name];

--Task 07
SELECT TOP (5)
	c.[Name],
	COUNT(*)
FROM Categories AS c
	JOIN Reports AS r ON r.CategoryId = c.Id
GROUP BY c.[Name]
ORDER BY COUNT(r.Id) DESC,  c.[Name];

--Task 08
SELECT
	u.Username,
	c.[Name] AS CategoryName
FROM
Users AS u
	JOIN Reports AS r ON r.UserId = u.Id
	JOIN Categories AS c ON c.Id = r.CategoryId
WHERE DATEPART(MONTH, u.Birthdate) = DATEPART(MONTH, r.OpenDate) AND DATEPART(DAY, u.Birthdate) = DATEPART(DAY, r.OpenDate)
ORDER BY u.Username, c.[Name]

--Task 09

SELECT
	CONCAT_WS(' ', e.FirstName, e.LastName) AS FullName,
	COUNT(u.Username)
FROM Employees AS e
	LEFT JOIN Reports AS r ON r.EmployeeId = e.Id
	LEFT JOIN Users AS u ON u.Id = r.UserId
GROUP BY CONCAT_WS(' ', e.FirstName, e.LastName)
ORDER BY COUNT(u.Username) DESC, CONCAT_WS(' ', e.FirstName, e.LastName);

--Task 10

SELECT
	CONCAT_WS(' ', e.FirstName, e.LastName) AS Employee,
	d.[Name] AS Department,
	c.[Name] AS Category,
	r.[Description],
	FORMAT(r.[OpenDate], 'dd.MM.yyyy') AS OpenDate,
	st.[Label] AS [Status],
	u.[Name]
FROM Employees AS e
	JOIN Departments AS d ON d.Id = e.DepartmentId
	JOIN Categories AS c ON c.DepartmentId = d.Id
	JOIN Reports AS r ON r.EmployeeId = e.Id
	JOIN [Status] AS st ON st.Id = r.StatusId
	JOIN Users AS u ON u.Id = r.UserId
ORDER BY e.FirstName DESC, e.LastName DESC, d.[Name], c.[Name], r.[Description], r.[OpenDate], st.[Label], u.[Name];


SELECT
	CASE
		WHEN COALESCE(e.FirstName, e.LastName) IS NOT NULL THEN CONCAT_WS(' ', e.FirstName, e.LastName)
		ELSE 'None'
	END AS Employee,
	ISNULL(d.[Name],'None') AS Department,
	ISNULL(c.[Name],'None') AS Category,
	ISNULL(r.[Description],'None') AS [Description],
	ISNULL(FORMAT(r.[OpenDate], 'dd.MM.yyyy'),'None') AS OpenDate,
	ISNULL(s.[Label],'None') AS [Status],
	ISNULL(u.[Name],'None') AS [User]
FROM Reports AS r
	LEFT JOIN Employees AS e ON e.Id = r.EmployeeId
	LEFT JOIN Categories AS c ON c.Id = r.CategoryId
	LEFT JOIN Departments AS d ON d.Id = e.DepartmentId
	LEFT JOIN [Status] AS s ON s.Id = r.StatusId
	LEFT JOIN Users AS u ON u.Id = r.UserId
ORDER BY e.FirstName DESC, e.LastName DESC, d.[Name], c.[Name], r.[Description], r.[OpenDate], s.[Label], u.[Name];