--Task 11
CREATE FUNCTION udf_AllUserCommits(@username VARCHAR(100))
RETURNS INT
AS
BEGIN
	RETURN (
		SELECT
			COUNT(*)
		FROM Commits AS c
			JOIN Users AS u ON u.Id = c.ContributorId
		WHERE u.Username = @username
		
	)
END
SELECT dbo.udf_AllUserCommits('UnderSinduxrein')
GO

--Task 12
CREATE PROCEDURE usp_SearchForFiles(@fileExtension VARCHAR(50))
AS
BEGIN
	SELECT
		Id,
		[Name],
		CONCAT(Size,'KB') AS Size
	FROM Files
	WHERE [Name] LIKE CONCAT('%', @fileExtension)
	ORDER BY Id, [Name], Size DESC
END

EXEC usp_SearchForFiles 'txt'