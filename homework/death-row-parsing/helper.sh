!/bin/bash

curl http://www.tdcj.state.tx.us/death_row/dr_offenders_on_dr.html -o data-hold/TX-death-row.html
curl http://www.tdcj.state.tx.us/death_row/dr_list_all_dr_1923-1973.html -o data-hold/TX-death-row-ALL.html
curl http://www.dc.state.fl.us/activeinmates/deathrowroster.asp -o data-hold/FL-death-row-roster.html
curl http://www.dc.state.fl.us/oth/deathrow/execlist.html -o data-hold/FL-exec-list-to-present.html
curl http://www.dc.state.fl.us/oth/deathrow/execlist2.html -o data-hold/FL-exec-list-to-1964.html
wget http://www.cdcr.ca.gov/capital_punishment/docs/condemnedinmatelistsecure.pdf | \
  pdftotext | \
  mv condemnedinmatelistsecure.txt CA-death-row.txt
rm condemnedinmatelistsecure.pdf

