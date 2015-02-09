# Get occupational codes

curl 'http://www.opm.gov/policy-data-oversight/classification-qualifications/general-schedule-qualification-standards/#url=List-by-Occupational-Series' | \
  pup 'th' text{} | \
  grep -oE '[[:digit:]]{4}' \
  > data-hold/OccupationalSeries.txt
