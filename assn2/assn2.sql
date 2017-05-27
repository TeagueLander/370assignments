CREATE OR REPLACE VIEW vCostars AS
	SELECT DISTINCT si1.movie, si1.celeb celeb1, si2.celeb celeb2
	FROM StarredIn si1
	JOIN StarredIn si2 ON si1.movie = si2.movie
	WHERE si1.celeb <> si2.celeb;

SELECT movie
	FROM vCostars
	WHERE celeb1 = 'Tom Cruise'
	AND celeb2 = 'Penélope Cruz';
	
SELECT UNIQUE(celeb2) celeb
	FROM vCostars
	WHERE celeb1 = 'Tom Cruise';
	
SELECT cs.celeb2 costar, cs.movie
	FROM vCostars cs
	JOIN Relationships r
		ON cs.celeb1 = r.celeb1
		AND cs.celeb2 = r.celeb2 
	WHERE cs.celeb1 = 'Tom Cruise';
	
SELECT cs.celeb1, cs.celeb2, cs.movie
	FROM vCostars cs
	JOIN Relationships r
		ON cs.celeb1 = r.celeb1
		AND cs.celeb2 = r.celeb2;
		
SELECT celeb, COUNT(movie)
	FROM StarredIn
	GROUP BY celeb
	HAVING COUNT(movie) >= 10
	ORDER BY COUNT(movie) DESC;