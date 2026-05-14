-- PART 1
-- Construct an SQL experiment to determine the AVG function's behavior when applied to a column that contains NULL values.
-- Create a table with type real
CREATE TEMP TABLE mytable (val REAL);
-- Insert some values, including NULL
-- Multiple rows can be inserted at once using a single INSERT with comma separated values
INSERT INTO mytable VALUES (5), (10), (NULL), (15);
-- calculate average
SELECT AVG (val) FROM mytable;
-- The result is 10, which means that the AVG function ignores NULL values when calculating the average. 
-- The AVG function only considers the non-NULL values in the calculation (5 + 10 + 15) / 3 = 10
-- If the function included NULL values, the result would be 7.5, where the denominator would be 4 instead of 3.

-- PART 2
-- Compute manually the average
SELECT SUM(val)/COUNT(*) FROM mytable;
SELECT SUM(val)/COUNT(val) FROM mytable;

-- The fist query returns 7.5 because COUNT(*) counts all rows, including the NULL value, giving a larger denominator and lowering the average.
-- The second query returns the correct average of 10 because COUNT(val) counts only the non-NULL values, giving the correct denominator for the average calculation
