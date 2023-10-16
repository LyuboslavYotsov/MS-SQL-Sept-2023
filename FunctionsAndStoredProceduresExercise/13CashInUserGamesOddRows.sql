CREATE OR ALTER FUNCTION ufn_CashInUsersGames (@GameName NVARCHAR(50))
RETURNS @Result TABLE(SumCash MONEY)
AS
BEGIN
INSERT INTO @Result
SELECT
SUM(rowData.Cash) AS [SumCash]
FROM
	(SELECT
	Cash,
	ROW_NUMBER() OVER (ORDER BY CASH DESC) AS [Row Number]
	FROM UsersGames AS ug
	JOIN Games AS g ON g.Id = ug.GameId
	WHERE g.[Name] = @GameName ) AS [rowData]
WHERE rowData.Cash % 2 <> 0

RETURN
END

SELECT * FROM dbo.ufn_CashInUsersGames('Love in a mist')