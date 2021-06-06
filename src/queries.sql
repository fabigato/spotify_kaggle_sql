\! echo most popular song per decade;
SELECT t.name, t.popularity, truncate(ifnull(YEAR(t.release_date), t.release_date), -1) decade
FROM db_music.tracks t
INNER JOIN (
    SELECT truncate(ifnull(YEAR(release_date), release_date), -1) decade, max(popularity) popularity
    FROM db_music.tracks
    GROUP BY decade
) t2 ON t.popularity = t2.popularity AND t2.decade = truncate(ifnull(YEAR(t.release_date), t.release_date), -1)
