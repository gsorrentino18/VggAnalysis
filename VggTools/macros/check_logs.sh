#!/bin/sh

VERSION=v00

if [ ! -z "$1" ]; then
  VERSION=$1
fi

WORKDIR=/home/$USER/work/cms/VggAnalysis/VggTools/macros

cd $WORKDIR

cat data/$VERSION/*.log | \
grep [a-z,A-Z] | \
grep -v 'Processing' | \
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
grep -v '#' | \
grep -v 'RoccoR::kScaleAndSmearMC' | \
sed -e 's;'$WORKDIR'/lists/;;'

exit
