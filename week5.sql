RECAP: VIEWS
============

- a view looks like a table
- stored in the database
- executed each time it is referenced
- handy way to make SQL more palatable
- ergo, similar to a function in a programming language

Ex: suppose we always want to see species names, not codes

CREATE VIEW Nest_view AS
    SELECT Book_page, Year, Site, Nest_ID, Scientific_name, Observer
    FROM Bird_nests JOIN Species
    ON Species = Code;

-- Looks just like Bird_nests but with code replaced by scientific name:

SELECT * FROM Nest_view LIMIT 1;
-- for comparison:
SELECT * FROM Bird_nests LIMIT 1;

-- Now use as usual (Using for a more substantial purpuse: counting eggs, but we'd like to see the nest ID and the scientific name for each nest):
-- As our bird_eggs table have multiple rows per nest, and our view has one row per nest, so, we have to tell SQL how to combine them using ANY_VALUE, which just picks one of the scientific names for each nest, since they are all the same:
SELECT Nest_ID, ANY_VALUE(Scientific_name), COUNT(*) AS Num_eggs
    FROM Nest_view JOIN Bird_eggs
    USING (Nest_ID)
    GROUP BY Nest_ID;

-- View compared to temp tables:
- Temp table is like a variable in a programming language
- As name suggests, table is deleted when database connection is closed
- Another option is to use a WITH clause, which creates a view
  for just that statement

Ex: take previous table, use it input to another query:
-- Use a WITH clause to create a view for just this statement, then use it to calculate the average number of eggs per species

WITH x AS (
  SELECT Nest_ID, ANY_VALUE(Scientific_name) AS Scientific_name,
    COUNT(*) AS Num_eggs
    FROM Nest_view JOIN Bird_eggs
    USING (Nest_ID)
    GROUP BY Nest_ID
  )
SELECT Scientific_name, AVG(Num_eggs) AS Avg_num_eggs FROM x
GROUP BY Scientific_name;
-- The variable ("x" in this case) only last for the statement, so can't be used in another query

SET OPERATIONS
==============
-- Recall that tables are **sets** of rows, not oredered lists
-- We can do set operation on tables
- UNION, INTERSECT, EXCEPT (set difference)
- these are set operations, so UNION eliminates duplicates
- to preserve duplicate rows, UNION ALL

--Example of UNION: let's create a table of all
--bird nests and egg counts, including nests that have no egg data recorded.
--In the quiz last week, we did this by

SELECT Nest_ID, COUNT(Egg_num) as Num_eggs
  FROM Bird_nests LEFT JOIN Bird_eggs
  USING (Nest_ID)
  GROUP BY Nest_ID;

-- left join include the row of all left, but the right if don't match will have nulls
-- it works, because the the null values inserted by the left join got discarted once the counts only the rows that havel egg_num

-- Using EXCEPT:
-- Let's try solving the same problem, but using UNION
-- 

SELECT Nest_ID, COUNT(*) AS Num_eggs
  FROM Bird_eggs
  GROUP BY Nest_ID

UNION

SELECT Nest_ID, 0 AS Num_eggs
  FROM Bird_nests
  WHERE Nest_ID NOT IN (SELECT DISTINCT Nest_ID FROM Bird_eggs);

- Caution: UNION not really looking at names of columns,
  just number of columns and data types
- So is possible to union nonsensical things together

-- Join conditions on a foreign key, two ways
-- ... ON Species = Code
-- ... ON Bird_nests.Nest_ID = Bird_eggs.Nest_ID
-- But just more compact to say ... USING (Nest_ID)
-- you can get away with *not* prefixing columns if they're unambiguous
-- but if the names are ambihupus, you need prefix them-- Note on UNIONS: SQL will UNION any two tables that have the same number of columns and compatible data type

--Example of when you might want to use EXCEPT:
-- Question: Which species do we *not* have data for?

Example of EXCEPT: 3rd way to get species that do *not* have nest data

-- First way
SELECT Code FROM Species
  WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

- Second way
SELECT Species, Code
  FROM Bird_nests RIGHT JOIN Species
  ON Species = Code
  WHERE Species IS NULL;

- Third way
SELECT Code FROM Species
  EXCEPT
  SELECT DISTINCT Species FROM Bird_nests;


## Enough with SELECT!

DATA MANAGEMENT STATEMENTS
==========================

- There's way more than just SELECT in SQL
- Already seen CREATE, INSERT
- More in https://www.sqlite.org/lang.html
- Can modify tables, schemas using ALTER
- DROP is counterpart to CREATE

-- INSERT statements
SELECT * FROM Personnel;
INSERT INTO Personnel VALUES ('miller', 'Hylaea');
SELECT * FROM Persinnel;

-- Good practice for safer code: name the columns
INSERT INTO Personnel (Abbreviation, Name) VALUES ('jbrun', 'Julien Brun');
-- Also, when you insert a row in a table, you don't necessarily have to specify all the values;
-- anything not specify will either be filled with NULL or
-- Also,, when you inser a row in a table, you don't necessarily
-- so that's another reason for spelling out the column names

-- Database typically have some kind of load functions to load data in bulk

-- Updates and deletes


UPDATE table SET ... WHERE ...
DELETE FROM table WHERE ...

- Caution!!!: these operate on whole tables if unqualified

SELECT * FROM Bird_nests LIMIT 10;

UPDATE Bird_nests
  SET floatAge = 6.5, ageMethod = 'float'
  WHERE Nest_ID = '14HPE1';
SELECT * FROM Bird_nests LIMIT 10;

- DELETE is similar
- Oops, what happens when accidentally do?:

-- THe weirs/terrible behavior: if no WHERE clause, they operate on **all** rows in the table

UPDATE Bird_nests
  SET floatAge = 4.5, ageMethod = 'float';

- There's no UNDO in databases
- In this class we can recover:

.exit
git restore database.duckdb
duckdb database.duckdb

- But in general, won't be a possibility, databases not typically
  under git control, usually stored on a server somewhere

- Strategies to avoid catastrophes
-- Just subconsciouly be careful, like holding a kitchen knife
-- Do SELECT first, then replace SELECT with DELETE <- allows inspection
   of what's about to be deleted

   SELECT * FROM Bird_nests WHERE Nest_ID = '98nome7';
   
-- Put comment in front: -- DELETE FROM ..., then remove comment
-- Tweak table name, put x in front, then remove