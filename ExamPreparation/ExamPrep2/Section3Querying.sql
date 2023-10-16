--Task 05
SELECT
Number,
Currency
FROM Invoices
ORDER BY Amount DESC, DueDate

--Task 06
SELECT
p.Id,
p.[Name],
p.Price,
c.[Name] AS CategoryName
FROM Products AS p
JOIN Categories AS c ON c.Id = p.CategoryId
WHERE c.[Name] IN ('ADR', 'Others')
ORDER BY p.Price DESC;

--Task 07

SELECT 
cl.Id,
cl.[Name] AS Client,
CONCAT_WS(', ', CONCAT_WS(' ',ad.StreetName, ad.StreetNumber), ad.City, ad.PostCode, cou.[Name]) AS Address
FROM Clients AS cl
LEFT JOIN ProductsClients AS pdc ON pdc.ClientId = cl.Id
JOIN Addresses AS ad ON ad.Id = cl.AddressId
JOIN Countries AS cou ON cou.Id = ad.CountryId
WHERE pdc.ProductId IS NULL
ORDER BY cl.[Name];


--Task 08
SELECT
TOP(7)
i.Number,
i.Amount,
cl.[Name] AS Client
FROM Invoices AS i
JOIN Clients AS cl ON cl.Id = i.ClientId
WHERE i.IssueDate < '2023-01-01' 
AND i.Currency = 'EUR'
OR i.Amount > 500.00
AND cl.NumberVAT LIKE 'DE%'
ORDER BY i.Number, i.Amount DESC;


--Task 09
SELECT
c.[Name],
MAX(p.Price) AS Price,
c.NumberVAT
FROM Clients AS c
JOIN ProductsClients AS pc ON pc.ClientId = c.Id
JOIN Products AS p ON p.Id = pc.ProductId
WHERE c.[Name] NOT LIKE '%KG'
GROUP BY c.[Name], c.NumberVAT
ORDER BY MAX(p.Price) DESC;

--Task 10
SELECT
c.[Name],
FLOOR(AVG(p.Price)) AS AveragePrice
FROM Clients AS c
LEFT JOIN ProductsClients AS pc ON pc.ClientId = c.Id
LEFT JOIN Products AS p ON p.Id = pc.ProductId
JOIN Vendors AS v ON v.Id = p.VendorId
WHERE pc.ProductId IS NOT NULL
AND v.NumberVAT LIKE '%FR%'
GROUP BY c.[Name]
ORDER BY FLOOR(AVG(p.Price)), c.[Name] DESC