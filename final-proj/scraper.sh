mkdir -p data-hold/press-releases

for num in $(seq 1 30); do
  curl -s "http://www.cruz.senate.gov/index.cfm?p=press_releases&pg=$num" > data-hold/$num.html
done

cat data-hold/*.html | \
  pup 'a attr{href}' | \
  grep -v 'index' | \
  grep 'press_release' > data-hold/rel-urls.txt

urls=$(cat data-hold/rel-urls.txt)

for line in $urls; do
  fname=$(echo $line | cut -c 26-)
  newLine=$(echo $line | sed 's/amp;//')
  curl -s "http://www.cruz.senate.gov$newLine" > data-hold/press-releases/$fname.html
  echo "Curling http://www.cruz.senate.gov$newLine ..."
  sleep 3
done
