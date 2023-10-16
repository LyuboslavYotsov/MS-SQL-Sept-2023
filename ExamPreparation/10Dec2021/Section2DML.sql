--Insert
INSERT INTO Passengers(FullName, Email)
SELECT
CONCAT_WS(' ', FirstName, LastName) AS FullName,
CONCAT(FirstName, LastName, '@gmail.com') AS Email
FROM Pilots
WHERE Id BETWEEN 5 AND 15


--Update
UPDATE Aircraft
SET Condition = 'A'
WHERE (Condition = 'C' OR Condition = 'B') AND (FlightHours IS NULL OR FlightHours <= 100) AND [Year] >= 2013

--Delete

DELETE
FROM Passengers
WHERE LEN(FullName) <= 10