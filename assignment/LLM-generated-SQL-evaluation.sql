-- Claude 

SELECT p.Name, COUNT(*) AS Num_floated_nests
FROM Bird_nests bn
JOIN Personnel p ON bn.Observer = p.Abbreviation
WHERE bn.Site = 'nome'
  AND bn.Year BETWEEN 1998 AND 2008
  AND bn.ageMethod = 'float'
GROUP BY p.Name
HAVING COUNT(*) = 36;


-- ChatGPT

SELECT 
    p.Name,
    COUNT(DISTINCT bn.Nest_ID) AS Num_floated_nests
FROM Bird_nests bn
JOIN Personnel p
    ON bn.Observer = p.Abbreviation
WHERE bn.Site = 'nome'
  AND bn.Year BETWEEN 1998 AND 2008
  AND bn.ageMethod = 'float'
GROUP BY p.Name
HAVING COUNT(DISTINCT bn.Nest_ID) = 36;

-- Gemini

SELECT 
    p.Name, 
    COUNT(bn.Nest_ID) AS Num_floated_nests
FROM Bird_nests bn
JOIN Personnel p ON bn.Observer = p.Abbreviation
WHERE bn.Site = 'nome' 
  AND bn.Year BETWEEN 1998 AND 2008
  AND bn.ageMethod = 'float'
GROUP BY p.Name
HAVING COUNT(bn.Nest_ID) = 36;

-- Evaluation:

-- 1. All three queries return the expected result
-- 2. Both Gemini and ChatGPT used COUNT(Nest_ID), not identifying that Nest_ID  is a primary key and cannot be NULL, making COUNT(*) sufficient.
-- ChatGPT went further by adding DISTINCT to the count, missing the meaning of a primary key and making the query redundant.
-- The rest of the queries were nearly identical, with Claude having the best understanding of the database.
