-- Calculate the average egg volume per nest
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG((3.14 / 6)* (Width * Width) * Length) AS Avg_volume
    FROM Bird_eggs
    GROUP BY Nest_ID;

-- Join with Bird_nests and Species, get max avg volume per species
SELECT scientific_name, MAX(Avg_volume) AS Max_avg_volume
    FROM Bird_nests JOIN Averages USING (Nest_ID)
    JOIN Species ON Bird_nests.Species = Species.code
    GROUP BY Scientific_name
    ORDER BY Max_avg_volume DESC;
