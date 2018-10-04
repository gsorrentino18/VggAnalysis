#!/bin/sh

cd /home/$USER/work/cms/CMSSW_9_4_9/
eval `scramv1 runtime -sh`
cd - > /dev/null

WORKDIR=/home/$USER/work/cms/VggAnalysis/VggTools/scripts

cd $WORKDIR

for F in `ls json/Run2016_*.json`; do
  echo "preparing pileup file for "`basename $F .json`
  pileupCalc.py -i $F \
                --inputLumiJSON /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions16/13TeV/PileUp/pileup_latest.txt \
                --calcMode true --minBiasXsec 69200 \
                --maxPileupBin 100 --numPileupBins 100 pileup/pileup_`basename $F .json`.root
done

for F in `ls json/Run2017_*.json`; do
  echo "preparing pileup file for "`basename $F .json`
  pileupCalc.py -i $F \
                --inputLumiJSON /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions17/13TeV/PileUp/pileup_latest.txt \
                --calcMode true --minBiasXsec 69200 \
                --maxPileupBin 100 --numPileupBins 100 pileup/pileup_`basename $F .json`.root

done

for F in `ls json/Run2018_*.json`; do
  echo "preparing pileup file for "`basename $F .json`
  pileupCalc.py -i $F \
                --inputLumiJSON /afs/cern.ch/cms/CAF/CMSCOMM/COMM_DQM/certification/Collisions18/13TeV/PileUp/pileup_latest.txt \
                --calcMode true --minBiasXsec 69200 \
                --maxPileupBin 100 --numPileupBins 100 pileup/pileup_`basename $F .json`.root

done

exit