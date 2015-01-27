#!/bin/bash

cat "data-hold/names-nationwide/yob$1.txt" "data-hold/names-nationwide/yob$2.txt" "data-hold/names-nationwide/yob$1.txt" | \
  cut -d ',' -f 1,2 | sort | uniq -c | grep 2 | cut -c 8- | sort | head -10
