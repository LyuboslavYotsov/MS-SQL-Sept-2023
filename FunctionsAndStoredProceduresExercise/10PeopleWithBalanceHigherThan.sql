CREATE OR ALTER PROC usp_GetHoldersWithBalanceHigherThan(@targetBalance MONEY)
AS
BEGIN
	SELECT
	ah.FirstName AS [First Name],
	ah.LastName AS [Last Name]
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON a.AccountHolderId = ah.Id
	GROUP BY ah.FirstName, ah.LastName, a.AccountHolderId
	HAVING SUM(a.Balance) > @targetBalance
	ORDER BY [First Name], [Last Name]
END


EXEC  usp_GetHoldersWithBalanceHigherThan 23000.5000