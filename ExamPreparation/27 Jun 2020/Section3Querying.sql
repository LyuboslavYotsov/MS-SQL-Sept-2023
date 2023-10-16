--Task 05
SELECT
	CONCAT_WS(' ', m.FirstName, m.LastName) AS Mechanic,
	j.[Status],
	j.IssueDate
FROM Mechanics AS m
	JOIN Jobs AS j ON j.MechanicId = m.MechanicId
ORDER BY m.MechanicId, j.IssueDate, j.JobId

--Task 06
SELECT
	CONCAT_WS(' ', c.FirstName, c.LastName) AS Client,
	DATEDIFF(DAY, j.IssueDate, '2017-04-24') AS DaysGoing,
	j.[Status]
FROM Clients AS c
	JOIN Jobs AS j ON j.ClientId = c.ClientId
WHERE j.[Status] != 'Finished'
ORDER BY DaysGoing DESC, c.ClientId

--Task 07
SELECT
	CONCAT_WS(' ', m.FirstName, m.LastName) AS Mechanic,
	AVG(DATEDIFF(DAY, j.IssueDate, j.FinishDate))
FROM Mechanics AS m
	JOIN Jobs AS j ON j.MechanicId = m.MechanicId
WHERE j.[Status] = 'Finished'
GROUP BY CONCAT_WS(' ', m.FirstName, m.LastName), m.MechanicId
ORDER BY m.MechanicId

--Task 08
SELECT
	CONCAT_WS(' ', m.FirstName, m.LastName) AS Available
FROM Mechanics AS m
	LEFT JOIN Jobs AS j ON m.MechanicId = j.MechanicId
WHERE j.MechanicId IS NULL OR j.[Status] = 'Finished'
GROUP BY m.MechanicId, CONCAT_WS(' ', m.FirstName, m.LastName)
ORDER BY m.MechanicId

--Task 09
SELECT 
	j.JobId,
	ISNULL(SUM(op.Quantity * p.Price), 0) AS Total
FROM Jobs AS j
	LEFT JOIN Orders AS o ON o.JobId = j.JobId
	LEFT JOIN OrderParts AS op ON op.OrderId = o.OrderId
	LEFT JOIN Parts AS p ON p.PartId = op.PartId
WHERE j.[Status] = 'Finished'
GROUP BY j.JobId
ORDER BY SUM(op.Quantity * p.Price) DESC, j.JobId


--Task 10
