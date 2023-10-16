CREATE OR ALTER PROC usp_GetTownsStartingWith (@targetString NVARCHAR(20))
	AS
	BEGIN
		SELECT
		[Name]
		FROM Towns
		WHERE @targetString = LEFT([Name], LEN(@targetString))
	END

	EXEC usp_GetTownsStartingWith 'b'