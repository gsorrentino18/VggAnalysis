#!/bin/bash

cd $HOME/work/cms/CMSSW_9_4_0/
eval `scramv1 runtime -sh`
source src/egm_tnp_analysis/etc/scripts/setup94.sh
cd $OLDPWD

WORKDIR=$HOME/work/cms/VggAnalysis/VggTools/tools
cd $WORKDIR

PYTHONPATH=$PYTHONPATH:$WORKDIR

YEAR="2016"

if [ ! -z "$1" ]; then
  YEAR=$1
fi

FLAGS="passingMedium94X HLTpath"

for F in $FLAGS; do

  python $HOME/work/cms/CMSSW_9_4_0/src/egm_tnp_analysis/tnpEGM_fitter.py  settings_ele_$YEAR.py --flag $F --createBins
  python $HOME/work/cms/CMSSW_9_4_0/src/egm_tnp_analysis/tnpEGM_fitter.py  settings_ele_$YEAR.py --flag $F --createHists
  python $HOME/work/cms/CMSSW_9_4_0/src/egm_tnp_analysis/tnpEGM_fitter.py  settings_ele_$YEAR.py --flag $F --doFit
  python $HOME/work/cms/CMSSW_9_4_0/src/egm_tnp_analysis/tnpEGM_fitter.py  settings_ele_$YEAR.py --flag $F --doFit --mcSig --altSig
  python $HOME/work/cms/CMSSW_9_4_0/src/egm_tnp_analysis/tnpEGM_fitter.py  settings_ele_$YEAR.py --flag $F --doFit --altSig
  python $HOME/work/cms/CMSSW_9_4_0/src/egm_tnp_analysis/tnpEGM_fitter.py  settings_ele_$YEAR.py --flag $F --doFit --altBkg
  python $HOME/work/cms/CMSSW_9_4_0/src/egm_tnp_analysis/tnpEGM_fitter.py  settings_ele_$YEAR.py --flag $F --sumUp

done

exit
