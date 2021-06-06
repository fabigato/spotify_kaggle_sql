CREATE DATABASE IF NOT EXISTS db_music;
USE db_music;
CREATE TABLE IF NOT EXISTS `artists` (
  `id` text,
  `followers` double DEFAULT NULL,
  `genres` text,
  `name` text,
  `popularity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOAD DATA INFILE '/dataset/artists.csv'
INTO TABLE artists
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'  -- the OPTIONAL keyword fixes errors due to commas within double quotes (ERROR 1261 (01000): Row 130435 doesn't contain data for all columns)
ESCAPED BY '\b' -- there are rows with \ as value. Here we change the escaping character to something more innocuous 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS `tracks` (
  `id` text,
  `name` text,
  `popularity` int DEFAULT NULL,
  `duration_ms` int DEFAULT NULL,
  `explicit` int DEFAULT NULL,
  `artists` text,
  `id_artists` text,
  `release_date` text,
  `danceability` double DEFAULT NULL,
  `energy` double DEFAULT NULL,
  `key` int DEFAULT NULL,
  `loudness` double DEFAULT NULL,
  `mode` int DEFAULT NULL,
  `speechiness` double DEFAULT NULL,
  `acousticness` double DEFAULT NULL,
  `instrumentalness` double DEFAULT NULL,
  `liveness` double DEFAULT NULL,
  `valence` double DEFAULT NULL,
  `tempo` double DEFAULT NULL,
  `time_signature` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOAD DATA INFILE '/dataset/tracks.csv'
INTO TABLE tracks
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\b'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
