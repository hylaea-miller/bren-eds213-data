-- Part 1: Egg variance

-- Step 1
-- Create table nest big and egg big
CREATE TABLE Nests_big AS SELECT * FROM 'nests_big.csv';
CREATE TABLE Eggs_big AS SELECT * FROM 'eggs_big.csv';

-- Explore tables
SELECT COUNT(*) FROM Nests_big;
SELECT COUNT(*) FROM Eggs_big;
SELECT * FROM Nests_big
LIMIT 5;
SELECT * FROM Eggs_big
LIMIT 5;
SHOW Nests_big;
SHOW Eggs_big;

-- Step 2
-- Join tables
CREATE TEMP TABLE join_temp AS
  SELECT * FROM eggs_big
  JOIN nests_big USING (Nest_ID)
  JOIN Species ON Nests_big.Species = Species.Code
  WHERE Species.Scientific_name = 'Calidris alpina';
    
-- Step 3
-- Select only the Site column and compute an egg volume column
SELECT Site, (3.14/6) * (Width * Width) * Length AS Volume
    FROM join_temp;
-- Step 4
--- Replace site with longitude

CREATE TEMP TABLE long_temp AS 
SELECT Site.Longitude, (3.14/6) * (Width * Width) * Length AS Volume
    FROM join_temp
    JOIN Site ON join_temp.Site = Site.Code;

-- Step 5 / step 6
-- Fix longitude values
CREATE TEMP TABLE final_temp AS 
SELECT CASE WHEN Longitude > 0 THEN Longitude - 360 ELSE Longitude END AS Longitude,
    Volume FROM long_temp;

-- Step 7
-- Compute linear regression slope and Pearson correlation coefficient
SELECT regr_slope(Volume, Longitude) AS Slope,
    corr(Volume, Longitude) AS PCC
FROM final_temp;

-- Part 2: Questions

1. 
-- Answer: No, because there is no specification of a primary or foreign key

2. 
-- Answer: 
-- I could use SELECT MIN and MAX, for example:
SELECT MIN(Longitude), MAX(Longitude) FROM Site;

3.
-- Answer:
-- The PCC of -0.108 indicates a very weak negative correlation between egg volume and longitude for Calidris alpina in Arctic Canada.
-- Being close to zero, it suggests almost no linear relationship, meaning egg volume decreases only slightly as longitude increases.

