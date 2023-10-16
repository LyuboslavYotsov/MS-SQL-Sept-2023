--Lab Tasks
--Lab Task 1
GO
CREATE OR ALTER FUNCTION udf_GetSalaryLevel(@Salary MONEY)
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(10)

	IF (@Salary < 30000)
		BEGIN
			SET @salaryLevel = 'Low'
		END
	ELSE IF(@Salary <= 50000)
		BEGIN
			SET @salaryLevel = 'Average'
		END
	ELSE 
		BEGIN
			SET @salaryLevel = 'High'
		END

		RETURN @salaryLevel
END;
GO
GO
SELECT
FirstName,
LastName,
Salary,
dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel
FROM Employees;
GO


--Task 01
GO
	CREATE PROC usp_GetEmployeesSalaryAbove35000
	AS
	BEGIN
		SELECT
		FirstName,
		LastName
		FROM Employees
		WHERE Salary > 35000;
	END

	EXEC dbo.usp_GetEmployeesSalaryAbove35000
GO

--Task 02
GO
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
GO

--Task 03
GO
	CREATE OR ALTER PROC usp_GetTownsStartingWith (@targetString NVARCHAR(20))
	AS
	BEGIN
		SELECT
		[Name]
		FROM Towns
		WHERE @targetString = LEFT([Name], LEN(@targetString))
	END

	EXEC usp_GetTownsStartingWith 'b'
GO


--Task 04
GO
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
GO

--Task 05
GO
CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(10)

	IF (@Salary < 30000)
		BEGIN
			SET @salaryLevel = 'Low'
		END
	ELSE IF(@Salary <= 50000)
		BEGIN
			SET @salaryLevel = 'Average'
		END
	ELSE 
		BEGIN
			SET @salaryLevel = 'High'
		END

		RETURN @salaryLevel
END;
GO


