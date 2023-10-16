CREATE OR ALTER PROC usp_GetEmployeesSalaryAboveNumber(@targetSalary DECIMAL(18,4))
	AS
	BEGIN
		SELECT
		FirstName,
		LastName
		FROM Employees
		WHERE Salary >= @targetSalary;
	END

	EXEC usp_GetEmployeesSalaryAboveNumber 48100