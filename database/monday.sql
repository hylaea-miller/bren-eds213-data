--First review item: tri-value logic
--Expression can have a value (if Boolean, TRUE or FALSE), but they can also be NULL
--In selecting rows, NULL doesn't count as TRUE
--Example: 
SELECT COUNT(*) FROM Bird_nests

--Review item: relationa algebrea
--Everything id s table! returns a table

SELECT COUNT(*) FROM Bird_nests;

We looked at one example of nesting SELECTs

SELECT Scientific_name
FROM SPECIES
WHERE Code NOT IN ( SELECT DISTINCT Species FROM Bird_nests);

--Let's pretend that SQL didn't have a HAVING clause. Could we somehow get the same functionality using a nested query?
--Let's go back to the example where we used a HAVING clause

SELECT Location, MAX(Area) AS Max_area
FROM Site
WHERE Location LIKE '%Canada'
GROUP BY Location
HAVING Max_area > 200;

As a reminder, the Site table:
SELECT * FROM Site LIMIT 5;

-- If we don't have a HAVING clause, we can stil get the same result by nesting the query.
SELECT * FROM
    (SELECT Location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location)
  where Max_area > 200;
-- We use %Canada to match any location that ends with 'canada'

-- REVIEW AND CONTINUE DISCUSSION OF JOINS
--
-- What is a join? COnceptually, the database performs a "Cartesian product" of the two tables, which means it combines every row of the first table with every row of the second table. Then, it applies the join condition to filter the results and return only the rows that satisfy the condition.
-- In some database, to do a cartesian product you would just do a JOIN without a condition e.g., 
--SELECT * FROM  a JOIN b;

SELECT * FROM A CROSS JOIN B;
SELECT * FROM A;
SELECT * FROM B;

-- here's what the Cartesian product looks like:
SELECT *FROM A CROSS JOIN B;

--Let's add a join condition, which can be *any* expression that involves columns from both tables.

SELECT * FROM A JOIN B ON acol1 < bcol1;

--This is what's referd to as an INNER JOIN
SELECT * FROM A INNER JOIN B ON  acol1 < bcol1;

--Outer joins: we're adding rows from one table that never got matched to the other table;

SELECT * FROM A RIGHT JOIN B ON acol1 < bcol1;

-- Do a FULL OUTER JOIN to get both missing sides (rare)

-- In the case of a join on a foreign key, the effect is to add columns to the "many" table

SELECT * FROM House;
SELECT * FROM Student;
.schema

SELECT * FROM Student S JOIN House H ON S.House_ID = H.House_ID;
-- As an aside, without aliased. the query would be:
SELECT * FROM Student JOIN House ON Student.House_ID = House.House_ID;

-- more compact:
-- One nice benefit of joining on a column that has the same name (i.e. House_ID here) is you can use USING CLAUSE 
-- 
SELECT * FROM Student JOIN House USING (House_ID);

-- switch to ASDN database

SELECT COUNT(*) FROM Bird_eggs;

-- For better viewing:
.mode line

SELECT COUNT(*) FROM Bird_eggs LIMIT 1;
SELECT * FROM Bird_eggs JOIN bird_nests USING (Nest_ID) LIMIT 1;
SELECT COUNT(*) FROM Bird_eggs JOIN Bird_nests USING (Nest_ID);

.mode duckbox

-- Import point! Ordering is assuredly lost doing a JOIN. dO DON'T SAY THIS:
-- Ordering should always and only be the very last thing

SELECT * FORM
(SELECT * FROM Bird_eggs ORDER BY Width)
JOIN Bird_nests
USING (Nest_ID);

-- Gotch with DuckDB... it's not as smart as some other databases to recognize primary keys in joins

SELECT Nest_ID, COUNT(*)
  FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  GROUP BY Nest_ID;

  -- Some databases allow you to say:

SELECT Nest_ID, Species, COUNT(*)
  FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  GROUP BY Nest_ID;

  -- Can we add another column from Bird_nests?  Other RDBMs's say yes
-- DuckDB: no
-- So follow DuckDB's suggestions

SELECT Nest_ID, ANY_VALUE(Species), COUNT(*)
  FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  GROUP BY Nest_ID;

SELECT Nest_ID, Species, COUNT(*)
  FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
  GROUP BY Nest_ID, Species;

