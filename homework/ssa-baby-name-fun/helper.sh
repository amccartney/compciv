#!/bin/bash

mkdir -p data-hold
cd data-hold
mkdir -p names-by-state
cd names-by-state
curl -o namesbystate.zip  http://stash.compciv.org/ssa_baby_names/namesbystate.zip
unzip namesbystate.zip
rm namesbystate.zip
cd ..
mkdir -p names-nationwide
cd names-nationwide
curl -o namesnationwide.zip http://stash.compciv.org/ssa_baby_names/names.zip
unzip namesnationwide.zip
rm namesnationwide.zip
cd ..
