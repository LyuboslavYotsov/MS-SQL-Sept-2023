--Task 11
CREATE FUNCTION udf_ProductWithClients(@name NVARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @count INT =
	(SELECT
	COUNT(*)
	FROM Clients AS c
	LEFT JOIN ProductsClients AS pc ON pc.ClientId = c.Id
	LEFT JOIN Products AS p ON p.Id = pc.ProductId
	WHERE p.[Name] =  @name)

	RETURN @count
END

SELECT dbo.udf_ProductWithClients('DAF FILTER HU12103X')
GO

--Task 12
CREATE PROC usp_SearchByCountry(@country NVARCHAR(50))
AS
BEGIN
	SELECT
	v.[Name],
	v.NumberVAT,
	CONCAT_WS(' ', ad.StreetName, ad.StreetNumber) AS [Street Info],
	CONCAT_WS(' ', ad.City, ad.PostCode) AS [City Info]
	FROM Vendors AS v
	JOIN Addresses AS ad ON ad.Id = v.AddressId
	JOIN Countries AS c ON c.Id = ad.CountryId
	WHERE c.[Name] = @country
	ORDER BY v.[Name], ad.City

END

EXEC usp_SearchByCountry 'France'