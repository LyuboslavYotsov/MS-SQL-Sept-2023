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
END
GO
SELECT dbo.ufn_GetSalaryLevel (13500.00)