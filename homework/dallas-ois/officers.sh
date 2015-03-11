incidents=$(cat tables/incidents.psv)

printf 'CASE NUM|DATE|SUSPECT KILLED|SUSPECT WEAPON|LAST NAME|FIRST NAME|RACE|GENDER\n'

cat tables/incidents.psv | while read x; do

  officers=$(echo $x |csvfix order -f 7 -smq -sep '|' | \
    sed -e 's/Jr. //g' | \
    tr ' ' '|' | tr '/' '|' | sed -e 's/,//g' | sed -e 's/"//g')

  officer_split=$(echo $officers | sed "s/\/M/\/M#/g" | \
    sed "s/\/F/\/M#/g" | \
    grep -oE "[^#]+")

echo $officer_split

  id=$(echo $x | csvfix order -f 1 -smq -sep '|' | sed -e 's/,//g')

#  echo $id

  date=$(echo $x | csvfix order -f 2 -smq -sep '|')

#  echo $date

  suspect_status=$(echo $x | csvfix order -f 4 -smq -sep '|')

#  echo $suspect_status

   if [[ "$suspect_status" == "Deceased" ]]; then
      suspect_killed="TRUE"
    else
      suspect_killed="FALSE"
    fi

  suspect_weapon=$(echo $x | csvfix order -f 5 -smq -sep '|')

  printf '%s|%s|%s|%s|%s\n', "$id" "$date" "$suspect_killed" "$suspect_weapon" "$officers"
done

