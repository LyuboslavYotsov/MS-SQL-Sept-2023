--Task 05
SELECT
	[Name],
	Price,
	[Description]
FROM Products
ORDER BY Price DESC, [Name]

--Task 06
SELECT
	fb.ProductId,
	fb.Rate,
	fb.[Description],
	fb.CustomerId,
	c.Age,
	c.Gender
FROM Feedbacks AS fb
	JOIN Customers AS c ON c.Id = fb.CustomerId
WHERE fb.Rate < 5.00
ORDER BY fb.ProductId DESC, fb.Rate

--Task 07
SELECT
	CONCAT_WS(' ', c.FirstName, c.LastName) AS CustomerName,
	c.PhoneNumber,
	c.Gender
FROM Customers AS c 
	LEFT JOIN Feedbacks AS fb ON fb.CustomerId = c.Id
WHERE fb.Id IS NULL
ORDER BY c.Id

--Task 08
SELECT
	c.FirstName,
	c.Age,
	c.PhoneNumber
FROM Customers AS c
	JOIN Countries AS cou ON cou.Id = c.CountryId
WHERE (c.Age >= 21 AND c.FirstName LIKE '%an%') OR (RIGHT(c.PhoneNumber,2) = '38' AND cou.[Name] != 'Greece')
ORDER BY c.FirstName, c.Age DESC;

--Task 09
SELECT
	d.[Name] AS DistributorName,
	i.[Name] AS IngredientName,
	p.[Name] AS ProductName,
	AVG(fb.Rate) AS AverageRate
FROM Distributors AS d
	JOIN Ingredients AS i ON i.DistributorId = d.Id
	JOIN ProductsIngredients AS pin ON pin.IngredientId = i.Id
	JOIN Products AS p ON p.Id = pin.ProductId
	JOIN Feedbacks AS fb ON fb.ProductId = p.Id
GROUP BY d.[Name], i.[Name], p.[Name] HAVING AVG(fb.Rate) BETWEEN 5 AND 8
ORDER BY d.[Name], i.[Name], p.[Name]

--Task 10
SELECT
query.CountryName,
query.DistributorName
FROM
	(SELECT
		c.[Name] AS CountryName,
		d.[Name] AS DistributorName,
		COUNT(*) AS [Count],
		DENSE_RANK() OVER (PARTITION BY c.[Name] ORDER BY COUNT(i.Id) DESC) AS [Rank]
	FROM Countries AS c
		JOIN Distributors AS d ON d.CountryId = c.Id
		LEFT JOIN Ingredients AS i ON i.DistributorId = d.Id
	GROUP BY c.[Name],d.[Name]) AS query
WHERE query.[Rank] = 1
ORDER BY query.CountryName, query.DistributorName
