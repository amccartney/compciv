#!/bin/bash

cat data-hold/TX-death-row-ALL.html | pup 'td:nth-of-type(4) text{}' > TX.txt
cat data-hold/TX-death-row.html | pup 'td:nth-of-type(7) text{}' >> TX.txt

