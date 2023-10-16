--Task 11

CREATE FUNCTION udf_CreatorWithBoardgames(@name NVARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @count INT =
	(SELECT
	COUNT(*)
	FROM Creators AS c
	JOIN CreatorsBoardgames AS cbg ON cbg.CreatorId = c.Id
	WHERE c.FirstName = @name)
	RETURN @count
END

SELECT dbo.udf_CreatorWithBoardgames('Bruno')
GO


--Task 12

CREATE OR ALTER PROC usp_SearchByCategory(@category NVARCHAR(50))
AS
BEGIN
	SELECT
	bg.[Name],
	bg.YearPublished,
	bg.Rating,
	c.[Name] AS CategoryName,
	p.[Name] AS PublisherName,
	CONCAT_WS(' ', pr.PlayersMin, 'people') AS MinPlayers,
	CONCAT_WS(' ', pr.PlayersMax, 'people') AS MaxPlayers
	FROM Boardgames AS bg
	JOIN Categories AS c ON c.Id = bg.CategoryId
	JOIN Publishers AS p ON p.Id = bg.PublisherId
	JOIN PlayersRanges AS pr ON pr.Id = bg.PlayersRangeId
	WHERE c.[Name] = @category
	ORDER BY p.[Name], YearPublished DESC

END

EXEC usp_SearchByCategory 'Wargames'