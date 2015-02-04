#!/bin/bash

mkdir -p ./data-hold
cd data-hold

curl http://stash.compciv.org/ssa_baby_names/names.zip > names.zip

unzip -p names.zip yob1973.txt yob2013.txt | dos2unix > namesample.txt

cd ..
