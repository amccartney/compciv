#!/bin/bash

cat data-hold/names-by-state/*.TXT | \
  grep "$1" | awk -F ',' '{print $4}' | sort | uniq -u #| grep "$1" | sort | cut -d ',' -f 1,2,4,5 
