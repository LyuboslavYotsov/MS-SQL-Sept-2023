--Task 11
CREATE FUNCTION udf_RoomsWithTourists(@name VARCHAR(50)) 
RETURNS INT
AS
BEGIN
	RETURN (SELECT
				SUM(b.AdultsCount + b.ChildrenCount)
			FROM Bookings AS b
				JOIN Rooms AS r ON b.RoomId = r.Id
			WHERE r.[Type] = @name)
END
GO

--Task 12
CREATE PROCEDURE usp_SearchByCountry(@country VARCHAR(50))
AS
BEGIN
	SELECT
		t.[Name],
		t.PhoneNumber,
		t.Email,
		COUNT(b.Id)
	FROM Tourists AS t
		JOIN Bookings AS b ON b.TouristId = t.Id
		JOIN Countries AS c ON c.Id = t.CountryId
	WHERE c.[Name] = @country
	GROUP BY t.[Name], t.PhoneNumber, t.Email
END

EXEC usp_SearchByCountry 'Greece'