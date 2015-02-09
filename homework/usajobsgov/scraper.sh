# Takes codes from text file and queries API database with those codes

os=$(cat data-hold/OccupationalSeries.txt)
current_time=$(date "+%Y-%m-%d_%H00")

mkdir -p data-hold/scrapes/$current_time
cd data-hold/scrapes/$current_time

for l in $os; do

  curl https://data.usajobs.gov/api/jobs?series=$l -s > $l.json
done


