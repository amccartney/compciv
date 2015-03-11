cat tables/geocodes.psv | tr '|' ',' > tables/tmp_geocodes.csv

cat data-hold/ois_2003.html | pup 'table table tr json{}' |
  jq  --raw-output '.[] .children | [
    .[0] .children[0] .href,
    .[0] .children[0] .text,
    .[1] .text ,
    .[2] .text,
    .[3] .text,
    .[4] .text,
    .[5] .text,
    .[6] .text,
    .[7] .text
  ] | @csv' | \
  csvfix order -f 2:9 > tables/tmp_tables.csv

  csvfix join -f 3:1 tables/tmp_tables.csv tables/tmp_geocodes.csv > tables/tmp_incidents.csv

  rm tables/tmp_tables.csv
  rm tables/tmp_geocodes.csv

cd data-hold/pdfs

echo 'case|description' > tmp_descriptions.psv

#remember to change .txt back to .pdf when done
for file in *.txt; do
  #pdftotext "$file" "$file.txt";
  #rm $file.pdf
  case=$(basename $file | cut -d'.' -f1 | cut -c 10-)
  description=$(cat $file | tr '\n' ' ')
  echo "^$case^,^$description^" | tr '^' '\"' >> tmp_descriptions.csv
done

cd ../..

csvfix join -f 1:1 tables/tmp_incidents.csv data-hold/pdfs/tmp_descriptions.csv | \
  csvfix echo -smq -osep '|'> tables/incidents.psv

  rm tables/tmp_incidents.csv
  rm data-hold/pdfs/tmp_descriptions.csv

#makes the officer table

incidents=$(cat incidents.psv)

for x in $incidents; do

  officers=$(echo $x |csvfix order -f 7 -smq -sep '|' | \
    sed -e 's/Jr. //g' | \
    tr '  ' '|' | tr ' ' '|' | tr '/' '|' | sed -e 's/,//g' | sed -e 's/"//g')

  id=$(echo $x | csvfix order -f 1 -smq -sep '|')

  date=$(echo $x | csvfix order -f 2 -smq -sep '|')

  suspect_status=$(echo $x | csvfix order -f 4 -smq -sep '|')

  suspect_killed=$(if [[ $suspect_status -eq "Deceased" ]]; then
      echo "TRUE"
    else
      echo "FALSE"
    fi)

  suspect_weapon=$(echo $x | csvfix order -f 5 -smq -sep '|')


