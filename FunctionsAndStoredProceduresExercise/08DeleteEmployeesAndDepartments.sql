CREATE PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
	
	DECLARE @employeesToDeleted TABLE([ID] INT)

	INSERT INTO @employeesToDeleted(ID)
	SELECT EmployeeID
	FROM Employees
	WHERE DepartmentID = @departmentId;

	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT;

	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT * FROM @employeesToDeleted);

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT * FROM @employeesToDeleted);

	DELETE
	FROM EmployeesProjects
	WHERE EmployeeID IN (SELECT * FROM @employeesToDeleted);

	DELETE
	FROM Employees
	WHERE EmployeeID IN (SELECT * FROM @employeesToDeleted);

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId;

	SELECT
	COUNT(*)
	FROM Employees
	WHERE DepartmentID = @departmentId;

END

BEGIN TRANSACTION
	EXEC usp_DeleteEmployeesFromDepartment 1
	SELECT
	COUNT(*)
	FROM Employees
	WHERE DepartmentID = 1;
	
ROLLBACK