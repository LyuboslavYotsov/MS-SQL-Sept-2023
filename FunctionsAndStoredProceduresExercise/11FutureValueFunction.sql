CREATE FUNCTION ufn_CalculateFutureValue (@InitialSum DECIMAL(18,4) , @YearlyRate FLOAT, @Years INT)
RETURNS DECIMAL(18,4)
AS
BEGIN
	DECLARE @result DECIMAL(18,4) = @InitialSum * POWER(@YearlyRate + 1, @Years)
	RETURN @result
END

SELECT dbo.ufn_CalculateFutureValue (1000, 0.1, 5)