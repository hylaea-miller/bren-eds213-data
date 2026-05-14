
# Store arguments in named variables
label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

# Get current time before loop
start=$SECONDS

# Loop num_reps times and run the query each time
for i in $(seq "$num_reps"); do
    duckdb "$db_file" "$query" > /dev/null 2>&1
done

# Get current time after loop
end=$SECONDS

# Compute elapsed time
elapsed=$((end - start))

# Divide elapsed time by num_reps to get average time per query
avg=$(python -c "print($elapsed / $num_reps)")

# Append result to CSV file
echo "$label,$avg" >> "$csv_file"
