bash query_timer.sh subquery 1000 \
    'SELECT Code FROM Species WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests)' \
    database.duckdb timings.csv

bash query_timer.sh outer_join 1000 \
    'SELECT Code FROM Bird_nests RIGHT JOIN Species ON Species = Code WHERE Nest_ID IS NULL' \
    database.duckdb timings.csv

bash query_timer.sh except 1000 \
    'SELECT Code FROM Species EXCEPT SELECT DISTINCT Species FROM Bird_nests' \
    database.duckdb timings.csv
