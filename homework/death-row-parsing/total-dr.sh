#!/bin/bash

bash tx-dr.sh
bash fl-dr.sh
bash ca-dr.sh

#!/bin/bash

bash tx-dr.sh
texas=`cat TX.txt`

for line in $texas; do
  echo TX,$line
done

bash fl-dr.sh
florida=$(cat FL.txt | sed 's/WM/White/' | sed 's/BM/Black/' | \
  sed 's/HM/Hispanic/' | sed 's/OM/Other/' | sed 's/WF/White/' | \
  sed 's/HF/Hispanic/' | sed 's/BF/Black/' | grep -v 'Gender')

for line in $florida; do
    echo FL,$line
done

bash ca-dr.sh
calif=$(cat CA.txt | sed 's/WHI/White/' | sed 's/BLA/Black/' | \
  sed 's/HIS/Hispanic/' | sed 's/OTH/Other/')

for line in $calif; do
  echo CA,$line
done

rm CA.txt
rm TX.txt
rm FL.txt
