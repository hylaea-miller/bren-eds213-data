-- Original query
SELECT *
    FROM Students
    WHERE (name = '%s' AND year = 2026);

-- Substituting Robert name (Robert'); DROP TABLE Students;--)
SELECT *
    FROM Students
    WHERE (name = 'Robert'); DROP TABLE Students;--' AND year = 2026);

-- The database would interpret the resulting string as two separate SQL commands due to the presence of the semicolon on bobby's name. 
-- The first command would be a SELECT statement that attempts to find a student named 'Robert'.
-- The second command would be a DROP TABLE statement that deletes the entire Students table. 
-- The double hyphens at the end of the input are used to comment out the rest of the original query, preventing any syntax errors from the remaining part of the query. 

-- Part 2

-- Original query
SELECT *
    FROM Students WHERE name = '%s';

-- Substituting for a name that would delete the table
SELECT *
    FROM Students WHERE name = 'Robert'); DROP TABLE Students;--';

-- Resulting bobby name of : 

Robert'; DROP TABLE Students;--

-- Bonus

-- Original query

SELECT * FROM Species WHERE Code = '%s';

-- Possible malicious input:

SELECT * FROM Species WHERE Code = 'wolv'; INSERT INTO Personnel (Abbreviation, Name) VALUES ('tswift', 'Taylor Swift'); --'; 
