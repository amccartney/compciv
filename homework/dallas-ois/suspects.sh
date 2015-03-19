# The incidents.psv table was corrected for spacing before running this script

incidents=$(cat tables/incidents.psv)

printf 'CASE NUM|DATE|SUSPECT KILLED|SUSPECT WEAPON|LAST NAME|FIRST NAME|RACE|GENDER\n'

cat tables/incidents.psv | while read x; do

  suspects=$(echo $x |csvfix order -f 6 -smq -sep '|' | \
    sed -e 's/Jr. //g' | \
    tr ' ' '|' | tr '/' '|' | sed -e 's/,//g' | sed -e 's/"//g')

  suspects_split=$(echo $suspects | sed "s/\/M/\/M#/g" | \
    sed "s/\/F/\/M#/g" | \
    grep -oE "[^#]+")

  id=$(echo $x | csvfix order -f 1 -smq -sep '|' | sed -e 's/,//g')

  date=$(echo $x | csvfix order -f 2 -smq -sep '|')

  suspect_status=$(echo $x | csvfix order -f 4 -smq -sep '|')

   if [[ "$suspect_status" == "Deceased" ]]; then
      suspect_killed="TRUE"
    else
      suspect_killed="FALSE"
    fi

  suspect_weapon=$(echo $x | csvfix order -f 5 -smq -sep '|')

  printf '%s|%s|%s|%s|%s\n' "$id" "$date" "$suspect_killed" "$suspect_weapon" "$suspects_split"

done
