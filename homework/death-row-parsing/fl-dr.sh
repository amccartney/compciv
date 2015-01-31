#!/bin/bash

cat data-hold/FL-death-row-roster.html data-hold/FL-exec-list-to-1964.html data-hold/FL-exec-list-to-present.html | \
  pup 'td:nth-of-type(3) text{}' > FL.txt
