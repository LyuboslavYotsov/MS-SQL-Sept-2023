--Task 11
CREATE FUNCTION udf_ClientWithCigars(@name NVARCHAR(50))
RETURNS INT
AS
BEGIN
	RETURN (SELECT
			COUNT(*)
			FROM Clients AS cl
			JOIN ClientsCigars AS cc ON cc.ClientId = cl.Id
			WHERE cl.FirstName = @name)
END
GO

--Task 12
CREATE PROCEDURE usp_SearchByTaste(@taste NVARCHAR(50))
AS
BEGIN
	SELECT
		c.CigarName,
		CONCAT('$', c.PriceForSingleCigar),
		t.TasteType,
		b.BrandName,
		CONCAT_WS(' ', s.[Length], 'cm') AS CigarLength,
		CONCAT_WS(' ', s.RingRange, 'cm') AS CigarRingRange
	FROM Cigars AS c
		JOIN Tastes AS t ON t.Id = c.TastId
		JOIN Brands AS b ON b.Id = c.BrandId
		JOIN Sizes AS s ON s.Id = c.SizeId
	WHERE t.TasteType = @taste
	ORDER BY s.[Length], s.RingRange DESC;
END
