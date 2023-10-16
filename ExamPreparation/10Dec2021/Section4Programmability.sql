--Task 11
CREATE FUNCTION udf_FlightDestinationsByEmail(@email VARCHAR(50))
RETURNS INT
AS
BEGIN
	RETURN (SELECT
				COUNT(*)
			FROM FlightDestinations AS fd
			JOIN Passengers AS p ON p.Id = fd.PassengerId
			WHERE p.Email = @email)
END
GO

--Task 12
CREATE PROCEDURE usp_SearchByAirportName(@airportName VARCHAR(70))
AS
BEGIN
	SELECT
		ap.AirportName,
		p.FullName,

			CASE
				WHEN fd.TicketPrice <= 400 THEN 'Low'
				WHEN fd.TicketPrice BETWEEN 401 AND 1500 THEN 'Medium'
				WHEN fd.TicketPrice > 1501 THEN 'High'
			END,

		ac.Manufacturer,
		ac.Condition,
		acT.TypeName
	FROM Airports AS ap
		JOIN FlightDestinations AS fd ON fd.AirportId = ap.Id
		JOIN Passengers AS p ON p.Id = fd.PassengerId
		JOIN Aircraft AS ac ON ac.Id = fd.AircraftId
		JOIN AircraftTypes AS acT ON act.Id = ac.TypeId
	WHERE ap.AirportName = @airportName
	ORDER BY ac.Manufacturer, p.FullName
END

EXEC usp_SearchByAirportName 'Sir Seretse Khama International Airport'