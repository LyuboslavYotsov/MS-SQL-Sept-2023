--Task 11
CREATE FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
BEGIN
	DECLARE @result INT = (SELECT DATEDIFF(HOUR, @StartDate, @EndDate))

	IF @result IS NULL
	SET @result = 0
	
	RETURN @result
END

GO


--Task 12
CREATE OR ALTER PROC usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
AS
BEGIN
	DECLARE @empoyeeDep INT = (SELECT DepartmentId FROM Employees WHERE Id = @EmployeeId)
	DECLARE @reportDep INT = (SELECT 
								c.DepartmentId
								FROM Reports AS r
								JOIN Categories AS c ON c.Id = r.CategoryId
								WHERE r.Id = @ReportId)

	IF @empoyeeDep = @reportDep
	BEGIN
		UPDATE Reports
		SET EmployeeId = @EmployeeId
		WHERE Id = @ReportId
	END

	ELSE 
	BEGIN
		SELECT 'Employee doesn''t belong to the appropriate department!'
	END
END


EXEC usp_AssignEmployeeToReport 30, 1
EXEC usp_AssignEmployeeToReport 17, 2
