CREATE OR ALTER PROC usp_EmployeesBySalaryLevel(@levelOfSalary VARCHAR(10))
AS
BEGIN

DECLARE @salary DECIMAL(18,4)

	SELECT
	FirstName,
	LastName
	FROM
	Employees
	WHERE @levelOfSalary = (SELECT dbo.ufn_GetSalaryLevel(Salary));
END

EXEC usp_EmployeesBySalaryLevel 'High'