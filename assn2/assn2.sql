-- VIEWS --
CREATE OR REPLACE VIEW vCostars AS
	SELECT DISTINCT si1.movie, si1.celeb celeb1, si2.celeb celeb2
	FROM StarredIn si1
	JOIN StarredIn si2 ON si1.movie = si2.movie
	WHERE si1.celeb <> si2.celeb;

CREATE OR REPLACE VIEW vCelebMovieCounts AS
	SELECT c.name celeb, COUNT(movie) movieCount
	FROM Celebs c
	LEFT JOIN StarredIn si ON c.name = si.celeb
	GROUP BY c.name;
	
CREATE OR REPLACE VIEW vCelebAlbumCounts AS
	SELECT c.name celeb, COUNT(album) albumCount
	FROM Celebs c
	LEFT JOIN Releases r ON c.name = r.celeb
	GROUP BY c.name;
	
-- SELECT STATEMENTS --
SELECT movie
	FROM vCostars
	WHERE celeb1 = 'Tom Cruise'
	AND celeb2 = 'Penélope Cruz';
	
SELECT UNIQUE(celeb2) celeb
	FROM vCostars
	WHERE celeb1 = 'Tom Cruise';
	
SELECT celeb2 costar, movie
	FROM vCostars
	NATURAL JOIN Relationships
	WHERE celeb1 = 'Tom Cruise';
	
SELECT celeb1, celeb2, movie
	FROM vCostars
	NATURAL JOIN Relationships;
		
SELECT celeb, COUNT(movie)
	FROM StarredIn
	GROUP BY celeb
	HAVING COUNT(movie) >= 10
	ORDER BY COUNT(movie) DESC;
	
SELECT r1.celeb2 celeb1, r2.celeb2 celeb2, r1.celeb1 celeb3
	FROM Relationships r1
	JOIN Relationships r2 ON r1.celeb1 = r2.celeb1
	WHERE r1.celeb2 <> r2.celeb2;
	
SELECT e.celeb1, e.celeb2, cmc1.movieCount, cmc2.movieCount
	FROM Enemies e
	JOIN vCelebMovieCounts cmc1 ON e.celeb1 = cmc1.celeb
	JOIN vCelebMovieCounts cmc2 ON e.celeb2 = cmc2.celeb;
	
SELECT celeb, albumCount
	FROM vCelebAlbumCounts
	WHERE albumCount >= 2
	ORDER BY albumCount DESC;
	
-- This is somewhat ambiguous, I'm assuming 'some' means more than one is allowed
SELECT celeb
	FROM vCelebAlbumCounts
	NATURAL JOIN vCelebMovieCounts
	WHERE movieCount > 0
	AND albumCount > 0;
	
SELECT celeb, movieCount number_of_movies, albumCount number_of_albums
	FROM vCelebAlbumCounts
	NATURAL JOIN vCelebMovieCounts
	WHERE movieCount > 0
	AND albumCount > 0;
	

