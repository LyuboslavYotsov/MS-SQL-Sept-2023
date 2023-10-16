--Task 05
SELECT
	CigarName,
	PriceForSingleCigar,
	ImageURL
FROM Cigars
ORDER BY PriceForSingleCigar, CigarName DESC;

--Task 06
SELECT
	c.Id,
	c.CigarName,
	c.PriceForSingleCigar,
	t.TasteType,
	t.TasteStrength
FROM Cigars AS c
JOIN Tastes AS t ON t.Id = c.TastId
WHERE t.TasteType IN ('Earthy', 'Woody')
ORDER BY c.PriceForSingleCigar DESC;


--Task 07

SELECT 
	c.Id,
	CONCAT_WS(' ', c.FirstName, c.LastName) AS ClientName,
	c.Email
FROM Clients AS c
LEFT JOIN ClientsCigars AS cc ON cc.ClientId = c.Id
WHERE cc.CigarId IS NULL
ORDER BY ClientName

--Task 08

SELECT TOP(5)
	c.CigarName,
	c.PriceForSingleCigar,
	c.ImageURL
FROM Sizes AS s
	JOIN Cigars AS c ON c.SizeId = s.Id
WHERE (s.Length >= 12) AND (c.CigarName LIKE ('%ci%') OR s.RingRange > 2.55 AND c.PriceForSingleCigar > 50)
ORDER BY c.CigarName, c.PriceForSingleCigar DESC;

--Task 09

SELECT
	CONCAT_WS(' ', FirstName, LastName) AS FullName,
	ad.Country,
	ad.ZIP,
	CONCAT('$',MAX(cig.PriceForSingleCigar)) AS CigarPrice
FROM Clients AS c
	JOIN Addresses AS ad ON ad.Id = c.AddressId
	JOIN ClientsCigars AS cc ON cc.ClientId = c.Id
	JOIN Cigars AS cig ON cig.Id = cc.CigarId
WHERE ISNUMERIC(ad.ZIP) = 1
GROUP BY CONCAT_WS(' ', FirstName, LastName), ad.Country, ad.ZIP
ORDER BY FullName

--Task 10
SELECT
	cl.LastName,
	CEILING(AVG(s.[Length])) AS CigarLength,
	CEILING(AVG(s.RingRange)) AS CigarRingRange
FROM Clients AS cl
	JOIN ClientsCigars AS cc ON cc.ClientId = cl.Id
	JOIN Cigars AS c ON c.Id = cc.CigarId
	JOIN Sizes AS s ON s.Id = c.SizeId
GROUP BY cl.LastName
ORDER BY AVG(s.[Length]) DESC;