--Task 05
SELECT
	Manufacturer,
	Model,
	FlightHours,
	Condition
FROM Aircraft
ORDER BY FlightHours DESC;

--Task 06
SELECT
	p.FirstName,
	p.LastName,
	a.Manufacturer,
	a.Model,
	a.FlightHours
FROM Pilots AS p
	JOIN PilotsAircraft AS pa ON pa.PilotId = p.Id
	JOIN Aircraft AS a ON a.Id = pa.AircraftId
WHERE a.FlightHours IS NOT NULL AND a.FlightHours < 304
ORDER BY a.FlightHours DESC, p.FirstName;

--Task 07
SELECT TOP(20)
	fd.Id AS DestinationId,
	fd.[Start],
	p.FullName,
	ap.AirportName,
	fd.TicketPrice
FROM FlightDestinations AS fd
	JOIN Passengers AS p ON P.Id = fd.PassengerId
	JOIN Airports AS ap ON ap.Id = fd.AirportId
WHERE DATEPART(DAY, fd.[Start]) % 2 = 0
ORDER BY TicketPrice DESC, ap.AirportName;

--Task 08
SELECT
	a.Id AS AircraftId,
	a.Manufacturer,
	a.FlightHours,
	COUNT(fd.Id) AS FlightDestinationsCount,
	ROUND(AVG(fd.TicketPrice), 2) AS AvgPrice
FROM Aircraft AS a
	LEFT JOIN FlightDestinations AS fd ON fd.AircraftId = a.Id
GROUP BY a.Id, a.Manufacturer, a.FlightHours HAVING COUNT(fd.Id) >= 2
ORDER BY COUNT(fd.Id) DESC, a.Id

--Task 09
SELECT
	p.FullName,
	COUNT(a.Id) AS CountOfAircraft,
	SUM(fd.TicketPrice) AS TotalPayed
FROM Passengers AS p
	JOIN FlightDestinations AS fd ON fd.PassengerId = p.Id
	JOIN Aircraft AS a ON fd.AircraftId = a.Id
WHERE SUBSTRING(p.FullName, 2,1) = 'a'
GROUP BY p.FullName HAVING COUNT(a.Id) > 1
ORDER BY p.FullName;


--Task 10

SELECT
	ap.AirportName,
	fd.[Start] AS DayTime,
	fd.TicketPrice,
	p.FullName,
	ac.Manufacturer,
	ac.Model
FROM FlightDestinations AS fd
	JOIN Airports AS ap ON ap.Id = fd.AirportId
	JOIN Passengers AS p ON p.Id = fd.PassengerId
	JOIN Aircraft AS ac ON ac.Id = fd.AircraftId
WHERE DATEPART(HOUR, fd.[Start]) BETWEEN 6 AND 20 AND fd.TicketPrice > 2500
ORDER BY ac.Model