mkdir -p data-hold/pdfs

curl http://www.dallaspolice.net/ois/ois.html -s > data-hold/ois_2003.html

for a in $(seq 3 9); do
  curl http://www.dallaspolice.net/ois/ois_200$a.html -s >> data-hold/ois_2003.html
done

for b in $(seq 10 12); do
  curl http://www.dallaspolice.net/ois/ois_20$b.html -s >> data-hold/ois_2003.html
done

cat data-hold/ois_2003.html -s | pup 'tr a attr{href}' | grep '/ois/docs/narrative/' > data-hold/pdfs/tmp.txt

cd data-hold/pdfs
doc=$(cat tmp.txt)

for l in $doc; do
  k=$(echo $l | cut -c 26-)
  curl http://www.dallaspolice.net$l -o $k
done

rm tmp.txt

cd ../..
