--Taks 05

SELECT
[Name],
Rating
FROM Boardgames
ORDER BY YearPublished, [Name] DESC;

--Task 06

SELECT
bg.Id,
bg.[Name],
YearPublished,
c.[Name]
FROM Boardgames AS bg
JOIN Categories AS c ON c.Id = bg.CategoryId
WHERE c.[Name] IN ('Strategy Games', 'Wargames')
ORDER BY YearPublished DESC;


--Task 07

SELECT 
Id,
CONCAT_WS(' ', FirstName, LastName) AS CreatorName,
Email
FROM Creators
WHERE Id NOT IN (SELECT CreatorId FROM CreatorsBoardgames)


--Task 08

SELECT TOP(5)
bg.[Name],
bg.Rating,
c.[Name] AS CategoryName
FROM Boardgames AS bg
JOIN Categories AS c ON c.Id = bg.CategoryId
JOIN PlayersRanges AS pr ON pr.Id = bg.PlayersRangeId
WHERE (bg.Rating > 7.00 AND bg.[Name] LIKE '%a%') OR (bg.Rating > 7.50 AND pr.PlayersMin = 2 AND pr.PlayersMax = 5)
ORDER BY bg.[Name], bg.Rating DESC


--Task 09
SELECT
dt.FullName,
dt.Email,
MAX(data.Rating)
FROM
	(SELECT
	CONCAT_WS(' ', c.FirstName, c.LastName) AS FullName,
	c.Email,
	bg.Rating AS Rating
	FROM Creators AS c
	JOIN CreatorsBoardgames AS cbg ON cbg.CreatorId = c.Id
	JOIN Boardgames AS bg ON bg.Id = cbg.BoardgameId
	WHERE c.Email LIKE '%.com') AS dt
GROUP BY FullName,Email
ORDER BY FullName

--Task 10
SELECT
c.LastName,
CEILING(AVG(bg.Rating)) AS AverageRating,
p.[Name] AS PublisherName
FROM Creators AS c
JOIN CreatorsBoardgames AS cbg ON cbg.CreatorId = c.Id
JOIN Boardgames AS bg ON bg.Id = cbg.BoardgameId
JOIN Publishers AS p ON p.Id = bg.PublisherId
WHERE p.[Name] = 'Stonemaier Games' AND cbg.CreatorId IS NOT NULL
GROUP BY c.LastName, p.[Name]
ORDER BY AVG(bg.Rating) DESC;
