--Task 05

SELECT
[Name],
Age,
PhoneNumber,
Nationality
FROM Tourists
ORDER BY Nationality, Age DESC, [Name];

--Task 06

SELECT 
s.[Name] AS [Site],
l.[Name] AS [Location],
s.Establishment,
c.[Name] AS Category
FROM Sites AS s
JOIN Locations AS l ON l.Id = s.LocationId
JOIN Categories AS c ON c.Id = s.CategoryId
ORDER BY c.[Name] DESC, l.[Name], s.[Name];

--Task 07

SELECT 
l.Province,
l.Municipality,
l.[Name] AS [Location],
COUNT(s.[Name])
FROM Locations AS l
JOIN Sites AS s ON s.LocationId = l.Id
WHERE l.Province = 'Sofia'
GROUP BY l.Province, l.Municipality, l.[Name]
ORDER BY COUNT(s.[Name]) DESC, l.[Name];

--Task 08

SELECT
	s.[Name] AS [Site],
	l.[Name] AS [Location],
	l.Municipality,
	l.Province,
	s.Establishment
FROM Sites AS s
	JOIN Locations AS l ON l.Id = s.LocationId
WHERE LEFT(l.[Name], 1) NOT IN ('B', 'M', 'D') AND s.Establishment LIKE '%BC'
ORDER BY s.[Name]


--Task 09

SELECT 
	t.[Name],
	t.Age,
	t.PhoneNumber,
	t.Nationality,
	CASE
		WHEN bp.[Name] IS NULL THEN '(no bonus prize)'
		ELSE bp.[Name]
	END AS Reward
FROM Tourists AS t
	LEFT JOIN TouristsBonusPrizes AS tbp ON tbp.TouristId = t.Id
	LEFT JOIN BonusPrizes AS bp ON bp.Id = tbp.BonusPrizeId
ORDER BY t.[Name];


--Task 10

SELECT
	SUBSTRING(t.[Name], CHARINDEX(' ', t.[Name]) + 1, LEN(t.[Name])) AS LastName,
	t.Nationality,
	t.Age,
	t.PhoneNumber
FROM Tourists AS t
	JOIN SitesTourists AS st ON st.TouristId = t.Id
	JOIN Sites AS s ON s.Id = st.SiteId
	JOIN Categories AS c ON c.Id = s.CategoryId
WHERE c.[Name] = 'History and archaeology'
GROUP BY SUBSTRING(t.[Name], CHARINDEX(' ', t.[Name]) + 1, LEN(t.[Name])), t.Nationality, t.Age, t.PhoneNumber
ORDER BY LastName