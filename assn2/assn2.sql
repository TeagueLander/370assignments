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

--Find the movies where both Tom Cruise and Penelope Cruz have starred together
SELECT movie
	FROM vCostars
	WHERE celeb1 = 'Tom Cruise'
	AND celeb2 = 'Penélope Cruz';
	
--Find all the co-stars of Nicolas Cage
SELECT UNIQUE(celeb2) celeb
	FROM vCostars
	WHERE celeb1 = 'Tom Cruise';
	
--Find the movies where Tom Cruise co-starred with a celebrity he is (or has been) in
--a relationship with
SELECT celeb2 costar, movie
	FROM vCostars
	NATURAL JOIN Relationships
	WHERE celeb1 = 'Tom Cruise';
	
--Find the movies where a celebrity co-starred with another celebrity he/she is (or has
--been) in relationship with
SELECT celeb1, celeb2, movie
	FROM vCostars
	NATURAL JOIN Relationships;

--Find how many movies each celebrity has starred in. Order the results by the number
--of movies (in descending order). Show only the celebrities who have starred in at
--least 10 movies
SELECT celeb, COUNT(movie)
	FROM StarredIn
	GROUP BY celeb
	HAVING COUNT(movie) >= 10
	ORDER BY COUNT(movie) DESC;
	
--Find the celebrities that have been in relationship with the same celebrity
SELECT r1.celeb2 celeb1, r2.celeb2 celeb2, r1.celeb1 celeb3
	FROM Relationships r1
	JOIN Relationships r2 ON r1.celeb1 = r2.celeb1
	WHERE r1.celeb2 <> r2.celeb2;
	
--For each pair of enemies give the number of movies each has starred in
SELECT e.celeb1, e.celeb2, cmc1.movieCount, cmc2.movieCount
	FROM Enemies e
	JOIN vCelebMovieCounts cmc1 ON e.celeb1 = cmc1.celeb
	JOIN vCelebMovieCounts cmc2 ON e.celeb2 = cmc2.celeb;

--Find how many albums each celebrity has released. Order the results by the number
--of albums (in descending order). Show only the celebrities who have released at least
--2 albums
SELECT celeb, albumCount
	FROM vCelebAlbumCounts
	WHERE albumCount >= 2
	ORDER BY albumCount DESC;
	
--Find those celebrity that have starred in some movie and have released some album
SELECT celeb
	FROM vCelebAlbumCounts
	NATURAL JOIN vCelebMovieCounts
	WHERE movieCount > 0
	AND albumCount > 0;
	
--For each celebrity that has both starred in some movie and released some album give
--the numbers of movies and albums he/she has starred in and released, respectively
SELECT celeb, movieCount number_of_movies, albumCount number_of_albums
	FROM vCelebAlbumCounts
	NATURAL JOIN vCelebMovieCounts
	WHERE movieCount > 0
	AND albumCount > 0;
	
--Find the earliest and the latest relationship (w.r.t the start date) recorded in this
--database
SELECT *
	FROM Relationships
	WHERE started IN ((SELECT MAX(started) FROM Relationships),
					  (SELECT MIN(started) FROM Relationships));

