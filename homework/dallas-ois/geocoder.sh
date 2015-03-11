##One line of data in ois_2013 will need to be fixed for the following to work properly
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
  grep '[1-9]' | \
  csvfix order -smq -f 4  > data-hold/tmp.txt

echo 'location|latitude|longitude' >  tables/geocodes.psv

addresses=$(cat data-hold/tmp.txt)

cat data-hold/tmp.txt | while read l; do
  k=$(echo $l | tr ' ' '+')
  lat=$(curl -s "https://maps.googleapis.com/maps/api/geocode/json?address=$k+Dallas,+TX&key=AIzaSyDdBsQKgsXLrHAil_feh5RK_g5lyxbRmAU" | jq '.results[0] .geometry .location .lat')
  lon=$(curl -s "https://maps.googleapis.com/maps/api/geocode/json?address=$k+Dallas,+TX&key=AIzaSyDdBsQKgsXLrHAil_feh5RK_g5lyxbRmAU" | jq '.results[0] .geometry .location .lng')
  echo "$l|$lat|$lon" >> tables/geocodes.psv
done

rm data-hold/tmp.txt
