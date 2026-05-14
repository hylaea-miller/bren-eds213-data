-- Find all pairs of people who worked at the same site with overlapping dates
SELECT A.Site, A.Observer AS Observer_1, B.Observer AS Observer_2
    FROM Camp_assignment A JOIN Camp_assignment B
    ON A.Site = B.Site
    AND (A.Start <= B.End) 
    AND (A.End >= B.Start)
    AND A.Observer < B.Observer
    WHERE A.Site = 'lkri';
    

-- Bonus: same query but with full names by joining Personnel twice
SELECT A.Site, P1.Name AS Name_1, P2.Name AS Name_2
    FROM Camp_assignment A JOIN Camp_assignment B
    ON A.Site = B.Site
    AND (A.Start <= B.End) 
    AND (A.End >= B.Start)
    AND A.Observer < B.Observer
    JOIN Personnel AS P1 ON A.Observer = P1.Abbreviation
    JOIN Personnel AS P2 ON B.Observer = P2.Abbreviation
    WHERE A.Site = 'lkri'
    ORDER BY Name_2;