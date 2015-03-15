list=$(cat twitter-hold/congress-screen-names.txt)
touch data-hold/tweets.csv

for name in $list; do
  t timeline -n 3200 --csv $name >> data-hold/tweets.csv
done
