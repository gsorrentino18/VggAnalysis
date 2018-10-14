#!/bin/sh

VERSION=v00

if [ ! -z "$1" ]; then
  VERSION=$1
fi

WORKDIR=/home/$USER/work/cms/VggAnalysis/VggTools/macros

cd $WORKDIR

for L in `ls data/$VERSION/*.log`; do
  O=`cat $L | \
  grep [a-z,A-Z] | \
  grep -v 'Processing' | \
  grep -v 'input list' | \
  grep -v 'Starting PROOF-Lite' | \
  grep -v 'Opening connections to workers:' | \
  grep -v 'Setting up worker servers:' |
  grep -v 'PROOF set to parallel mode' | \
  grep -v 'Info' | \
  grep -v "Looking up for exact location of files:" | \
  grep -v 'Validating files:' | \
  grep -v 'entries' | \
  grep -v 'TProof::Progress' | \
  grep -v 'Query processing time' | \
  grep -v 'Lite-0' | \
  grep -v '+++' | \
  grep -v '(M)' | \
  grep -v '#'`
  N=`echo "$O" | grep 'RoccoR::kScaleAndSmearMC' | wc -l`
  O=`echo "$O" | grep -v 'RoccoR::kScaleAndSmearMC'`
  echo -n 'Checking '`basename $L`" : "
  if [ -z "$O" ]; then
    if [ "$2" == "-d" ]; then
      echo "GOOD (known RoccoR::kScaleAndSmearMC = "$N")"
    else
      echo "GOOD"
    fi
  else
    if [ "$2" == "-d" ]; then
      echo "$O"
    else
      echo "ERROR"
    fi
  fi
done

exit
