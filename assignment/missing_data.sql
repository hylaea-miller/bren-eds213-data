-- Select sites that have no eggs using NOT IN
SELECT Code FROM Site
    WHERE Code NOT IN (SELECT Site FROM Bird_eggs)
    ORDER BY Code;

-- Select sites that have no eggs using LEFT JOIN and WHERE clause
SELECT Code FROM Site
    LEFT JOIN Bird_eggs ON Code = Bird_eggs.Site
    WHERE Bird_eggs.Site IS NULL
    ORDER BY Code;
