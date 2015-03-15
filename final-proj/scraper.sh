mkdir -p data-hold/press-releases
mkdir -p data-hold/menu-pages

# curl the menu pages of Cruz's press releases
for num in $(seq 1 30); do
  curl -s "http://www.cruz.senate.gov/index.cfm?p=press_releases&pg=$num" > data-hold/menu-pages/$num.html
done

# extract the relative urls of each press release from the menu pages
cat data-hold/menu-pages/*.html | \
  pup 'a attr{href}' | \
  grep -v 'index' | \
  grep 'press_release&' | \
  sed 's/amp;//' | \
  uniq > data-hold/rel-urls.txt

rm -rf data-hold/menu-pages

# curl each relative url and saves it into an html file with the press releases id number
urls=$(cat data-hold/rel-urls.txt)

for line in $urls; do

  fname=$(echo $line | cut -c 22-)

  curl -s "http://www.cruz.senate.gov$line" | \
  pup 'div#main' | \
  sed -e :a -e 's/<[^>]*>//g;/</N;//ba' | \
  sed 's/&#34;/"/g' | \
  sed "s/&#39;/'/g" > data-hold/press-releases/$fname.txt
  echo "Curling http://www.cruz.senate.gov$line ..."
  sleep 2
done
