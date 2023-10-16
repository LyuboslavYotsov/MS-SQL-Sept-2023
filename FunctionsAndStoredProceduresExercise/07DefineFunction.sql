CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(50), @word NVARCHAR(100))
RETURNS BIT
AS
BEGIN
	DECLARE @i INT = 1
	WHILE @i <= LEN(@word)
		BEGIN
		DECLARE @targetCh NVARCHAR(1) = SUBSTRING(@word, @i, 1)
			IF CHARINDEX(@targetCh, @setOfLetters) = 0
			RETURN 0

			ELSE
			SET @i += 1
		END
	RETURN 1
END

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')