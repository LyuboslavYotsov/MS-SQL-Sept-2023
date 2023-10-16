--Task 11

CREATE FUNCTION udf_GetTouristsCountOnATouristSite (@Site VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @count INT =
	(
		SELECT
			COUNT(*)
		FROM Tourists AS t
			JOIN SitesTourists AS st ON st.TouristId = t.Id
			JOIN Sites AS s ON s.Id = st.SiteId
		WHERE s.[Name] = @Site
	)

	RETURN @count
END
GO

--Task 12

CREATE PROCEDURE usp_AnnualRewardLottery(@TouristName VARCHAR(50))
AS
BEGIN
		SELECT
		t.[Name],
			CASE
				WHEN COUNT(s.[Name]) >= 100 THEN 'Gold badge'
				WHEN COUNT(s.[Name]) >= 50 THEN 'Silver badge'
				WHEN COUNT(s.[Name]) >= 25 THEN 'Silver badge'
			END AS Reward
		FROM Tourists AS t
			JOIN SitesTourists AS st ON st.TouristId = t.Id
			JOIN Sites AS s ON s.Id = st.SiteId
		WHERE t.[Name] = @TouristName
		GROUP BY t.[Name]
END

EXEC usp_AnnualRewardLottery 'Gerhild Lutgard'
EXEC usp_AnnualRewardLottery 'Teodor Petrov'
EXEC usp_AnnualRewardLottery 'Zac Walsh'
EXEC usp_AnnualRewardLottery 'Brus Brown'