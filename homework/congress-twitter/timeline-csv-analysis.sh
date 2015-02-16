#!/bin/bash

mkdir -p ./data-hold

echo "Fetching tweets for $1 into ./data-hold/$1-timeline.csv"

file=data-hold/$1-timeline.csv

t timeline -n 3200 --csv $1 > $file

count=$(csvfix order -f 1 $file | wc -l)

lastdate=$(csvfix order -fn 'Posted at' $file | tail -n 1)

echo "Analyzing $count tweets by $1 since $lastdate" 

echo "Top 10 hashtags by $1" 

  csvfix order -fn 'Text' $file | \
  tr '[[:upper:]]' '[[:lower:]]' | \
  grep -oE '#[a-z_-]+' | \
  sort | uniq -c | sort -nr | head -10

echo "Top 10 retweeted users by $1"

  csvfix order -fn 'Text' $file | \
  grep -oE 'RT @+[A-Za-z_-]+' | \
  grep -v $1 | \
  sort | uniq -c | sort -nr | head -10

echo "Top 10 mentioned users by $1"

  csvfix order -fn 'Text' $file | \
  grep -vE 'RT @+[A-Za-z_-]+' | \
  grep -oE '@+[A-Za-z_-]+' | \
  grep -v $1 | \
  sort | uniq -c | sort -nr | head -10

echo "Top 10 tweeted words is 5+ letters by $1"

  csvfix order -fn 'Text' $file | \
  sed 's/@/1/' | sed 's/#/2/' | \
  grep -oE '\b[[:alpha:]]{5,}' | \
  grep -v $1 | \
  grep -v 'https' | \
  tr '[[:upper:]]' '[[:lower:]]' | \
  sort | uniq -c | sort -nr | head -10

