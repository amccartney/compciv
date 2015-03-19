# takes one argument, the url of the page you want to check

curl -s "$1" | pup 'a attr{href}' > tmp.txt

dl_url=$(echo "$1" | cut -d '/' -f 1,2,3)

file=$(cat tmp.txt)

for l in $file; do
  if [[ "${l:0:2}" == "//" ]]; then
    echo "$l" | cut -c 3- >> tmp_urls.txt
  elif [[ "${l:0:1}" == "/" ]]; then
    echo "$dl_url$l" >> tmp_urls.txt
  else
    echo "$l" >> tmp_urls.txt
  fi
done

url_file=$(cat tmp_urls.txt | sort | uniq)

for n in $url_file; do
  code=$(curl -o /dev/null -s --write-out '%{http_code}\n' $n)
  echo $n,$code
done

rm tmp.txt
rm tmp_urls.txt
