--Task 05

SELECT
	[Name],
	PhoneNumber,
	[Address],
	AnimalId,
	DepartmentId
FROM Volunteers
ORDER BY [Name], AnimalId, DepartmentId;

--Task 06

SELECT
	a.[Name],
	atype.AnimalType,
	FORMAT(a.BirthDate, 'dd.MM.yyyy') AS BirthDate
FROM Animals AS a
	JOIN AnimalTypes AS atype ON atype.Id = a.AnimalTypeId
ORDER BY a.[Name];

--Task 07

SELECT TOP(5)
	o.[Name] AS [Owner],
	COUNT(*) AS CountOfAnimals
FROM Owners AS o
	JOIN Animals AS a ON a.OwnerId = o.Id
GROUP BY o.[Name]
ORDER BY COUNT(*) DESC, o.[Name];

--Task 08

SELECT
	CONCAT_WS('-', o.[Name], an.[Name]) AS OwnewrsAnimals,
	o.PhoneNumber,
	ac.CageId
FROM Owners AS o
	JOIN Animals AS an ON an.OwnerId = o.Id
	JOIN AnimalTypes AS ant ON ant.Id = an.AnimalTypeId
	JOIN AnimalsCages AS ac ON ac.AnimalId = an.Id
WHERE ant.AnimalType = 'Mammals'
ORDER BY o.[Name], an.[Name] DESC;

--Task 09

SELECT
	v.[Name],
	v.PhoneNumber,
	SUBSTRING(v.[Address], CHARINDEX(',', v.[Address]) + 1, LEN(v.[Address])) AS [Address]
FROM Volunteers AS v
	JOIN VolunteersDepartments AS vd ON vd.Id = v.DepartmentId
WHERE vd.DepartmentName = 'Education program assistant' AND v.[Address] LIKE '%Sofia%'
ORDER BY v.[Name];

--Task 10

SELECT
	a.[Name],
	DATEPART(YEAR, a.BirthDate) AS BirthYear,
	ant.AnimalType
FROM Animals AS a
	JOIN AnimalTypes AS ant ON a.AnimalTypeId = ant.Id
WHERE OwnerId IS NULL AND ant.AnimalType != 'Birds' AND DATEDIFF(YEAR , a.BirthDate, '2022-01-01') < 5
ORDER BY a.[Name];