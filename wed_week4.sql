SELECT * FROM B;
SELECT * FROM A;
--- Cross join review
SELECT * FROM A CROSS JOIN B;
--- SELECT always select columns from the FROM clause, so we can select specific columns from the cross join
SELECT acol1, acOl2 FROM (SELECT * FROM A CROSS JOIN B);

--- difference btw count(*) and count(column)
SELECT acol1, ANY_VALUE(acol2), COUNT(*)
  FROM (SELECT * FROM A CROSS JOIN B)
  GROUP BY acol1;


  SELECT acol1, ANY_VALUE(acol2), COUNT(bcol3)
  FROM (SELECT * FROM A CROSS JOIN B)
  GROUP BY acol1;


  --- USING a condition

SELECT * FROM A JOIN B ON acol1 < bcol1;

--- inner OUR outer JOINS
SELECT * FROM Student;
SELECT * FROM House;

--- INNER 
SELECT * FROM Student AS S JOIN House AS H ON S.House_ID = H.House_ID;

--- If they have the same name for the column, we can use USING
SELECT * FROM Student JOIN House USING (House_ID);

--- OUTER JOINS
SELECT * FROM Student FULL JOIN House USING (House_ID);

--- left JOIN
SELECT * FROM Student LEFT JOIN House USING (House_ID);
--- RIGHT JOIN
SELECT * FROM Student RIGHT JOIN House USING (House_ID);

--- CROSS JOIN
SELECT * FROM Student CROSS JOIN House;