--Task 11

CREATE FUNCTION udf_GetVolunteersCountFromADepartment (@VolunteersDepartment VARCHAR(50))
RETURNS INT
AS
BEGIN
	RETURN (SELECT
				COUNT(*)
			FROM Volunteers AS v
				JOIN VolunteersDepartments AS vd ON vd.Id = v.DepartmentId
			WHERE vd.DepartmentName = @VolunteersDepartment)
END

GO

--Task 12

CREATE PROC usp_AnimalsWithOwnersOrNot(@AnimalName VARCHAR(50))
AS
BEGIN
	SELECT
	a.[Name],
	CASE
		WHEN o.[Name] IS NULL THEN 'For adoption'
		ELSE o.[Name]
	END AS OwnersName
	FROM Animals AS a
	LEFT JOIN Owners AS o ON o.Id = a.OwnerId
	WHERE a.[Name] = @AnimalName
END

EXEC usp_AnimalsWithOwnersOrNot 'Pumpkinseed Sunfish'
EXEC usp_AnimalsWithOwnersOrNot 'Hippo'
EXEC usp_AnimalsWithOwnersOrNot 'Brown bear'