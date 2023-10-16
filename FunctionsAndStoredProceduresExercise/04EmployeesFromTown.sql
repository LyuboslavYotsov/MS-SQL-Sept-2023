CREATE OR ALTER PROC usp_GetEmployeesFromTown (@townName NVARCHAR(50))
	AS
	BEGIN
		SELECT
		e.FirstName,
		e.LastName
		FROM Employees AS e
		JOIN Addresses AS a ON e.AddressID = a.AddressID
		JOIN Towns AS t ON t.TownID = a.TownID
		WHERE t.[Name] = @townName;
	END

	EXEC usp_GetEmployeesFromTown 'Sofia'