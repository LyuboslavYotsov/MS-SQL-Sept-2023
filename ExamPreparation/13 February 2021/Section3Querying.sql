--Task 05
SELECT
	Id,
	[Message],
	RepositoryId,
	ContributorId
FROM Commits
ORDER BY Id, [Message], RepositoryId, ContributorId;

--Task 06
SELECT
	Id,
	[Name],
	Size
FROM Files
WHERE Size > 1000 AND [Name] LIKE '%html%'
ORDER BY Size DESC, Id, [Name];

--Task 07
SELECT
	i.Id,
	CONCAT_WS(' : ', u.Username, i.Title)
FROM Issues AS i
	JOIN Users AS u ON u.Id = i.AssigneeId
ORDER BY i.Id DESC, i.AssigneeId

--Task 08
SELECT
	Id,
	[Name],
	CONCAT(Size, 'KB')
FROM Files
WHERE Id NOT IN (SELECT
					ISNULL(ParentId, 0)
				FROM Files
				GROUP BY ParentId)
ORDER BY Id, [Name], Size DESC;

--Task 09
SELECT TOP(5)
	r.Id,
	r.[Name],
	COUNT(c.Id)
FROM Commits AS c
	JOIN Repositories AS r ON c.RepositoryId = r.Id
	JOIN RepositoriesContributors AS rc ON rc.RepositoryId = r.Id
GROUP BY r.Id, r.[Name]
ORDER BY COUNT(c.Id) DESC, r.Id, r.[Name]

--Task 10
SELECT
	u.Username,
	AVG(f.Size)
FROM Users AS u
	JOIN Commits AS c ON c.ContributorId = u.Id
	JOIN Files AS f ON f.CommitId = c.Id
GROUP BY u.Username
ORDER BY AVG(f.Size) DESC, u.Username