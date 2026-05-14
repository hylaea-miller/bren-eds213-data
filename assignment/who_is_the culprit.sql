-- Find the observer who floated exactly 36 nests at nome between 1998 and 2008
SELECT Personnel.Name, COUNT(*) AS Num_floated_nests
    FROM Bird_nests
    JOIN Personnel ON Bird_nests.Observer = Personnel.Abbreviation
    WHERE Bird_nests.Site = 'nome'
    AND Bird_nests.Year BETWEEN 1998 AND 2008
    AND Bird_nests.ageMethod = 'float'
    GROUP BY Personnel.Name
    HAVING COUNT(*) = 36;
