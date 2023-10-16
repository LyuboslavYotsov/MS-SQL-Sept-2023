--Task 05
SELECT
	FORMAT(b.ArrivalDate, 'yyyy-MM-dd') AS ArrivalDate,
	b.AdultsCount,
	b.ChildrenCount
FROM Bookings AS b
	JOIN Rooms AS r ON r.Id = b.RoomId
ORDER BY r.Price DESC, b.ArrivalDate


--Task 06
SELECT 
	h.Id,
	h.[Name]
FROM Hotels AS h
	JOIN HotelsRooms AS hr ON hr.HotelId = h.Id
	JOIN Rooms AS r ON r.Id = hr.RoomId
	JOIN Bookings AS b ON b.HotelId = h.Id
WHERE r.[Type] = 'VIP Apartment'
GROUP BY h.Id, h.[Name]
ORDER BY COUNT(b.Id) DESC;

--Task 07
SELECT
	t.Id,
	t.[Name],
	t.PhoneNumber
FROM Tourists AS t
	LEFT JOIN Bookings AS b ON b.TouristId = t.Id
WHERE b.TouristId IS NULL
ORDER BY t.[Name]

--Task 08
SELECT TOP(10)
	h.[Name],
	d.[Name],
	c.[Name]
FROM Bookings AS b
	JOIN Hotels AS h ON h.Id = b.HotelId
	JOIN Destinations AS d ON d.Id = h.DestinationId
	JOIN Countries AS c ON c.Id = d.CountryId
WHERE b.ArrivalDate < '2023-12-31' AND h.Id % 2 != 0
ORDER BY c.[Name], b.ArrivalDate

--Task 09
SELECT
	h.[Name] AS HotelName,
	r.Price AS RoomPrice
FROM Tourists AS t
	JOIN Bookings AS b ON b.TouristId = t.Id
	JOIN Hotels AS h ON h.Id = b.HotelId
	JOIN Rooms AS r ON r.Id = b.RoomId
WHERE t.[Name] NOT LIKE '%EZ'
ORDER BY r.Price DESC


--Task 10
SELECT
	dt.HotelName,
	SUM(dt.TotalRevenue) AS HotelRevenue
FROM
(SELECT
	h.[Name] AS HotelName,
	DATEDIFF(DAY, b.ArrivalDate, b.DepartureDate) AS NightsCount,
	r.Price * DATEDIFF(DAY, b.ArrivalDate, b.DepartureDate) AS TotalRevenue
FROM Bookings AS b
	JOIN Hotels AS h ON h.Id = b.HotelId
	JOIN Rooms AS r ON r.Id = b.RoomId) AS dt
GROUP BY dt.HotelName
ORDER BY SUM(dt.TotalRevenue) DESC