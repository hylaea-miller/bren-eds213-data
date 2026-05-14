-- Part 1
-- Find which site has the largest area
-- Test flawed query:
SELECT Site_name, MAX(Area) FROM Site;

-- This query is flawed because MAX(Area) collapses the entire table to a single row, but Site_name wants to return every row's value. 
-- Since SQL has no logical way to match which Site_name corresponds to the single MAX result, it just returns an error.

--Part 2
-- Find the site name and area of the site having the largest area
SELECT Site_name, Area FROM Site 
ORDER BY Area DESC LIMIT 1;

-- Part 3
-- Do the same, but use a nested query
SELECT Site_name, Area FROM Site 
WHERE Area = (SELECT MAX(Area) FROM Site);
