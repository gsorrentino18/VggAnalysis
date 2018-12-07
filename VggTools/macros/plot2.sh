#!/bin/sh

if [ -r $CMS_PATH/slc6_amd64_gcc700/cms/cmssw/CMSSW_10_2_5 ]; then
  cd $CMS_PATH/slc6_amd64_gcc700/cms/cmssw/CMSSW_10_2_5
  eval `scramv1 runtime -sh`
  cd $OLDPWD
  alias root-6.12=root
fi

WORKDIR=/home/$USER/work/cms/VggAnalysis/VggTools/macros
cd $WORKDIR

VERSION="v05"

if [ ! -z "$1" ]; then
  VERSION=$1
fi

YEARS="2016"

if [ ! -z "$2" ]; then
  if [ "$2" == "all" ]; then
    YEARS="2016 2017 2018"
  else
    YEARS=$2
  fi
fi

FLAGS="nolog,amcatnlo"

if [ ! -z "$3" ]; then
  FLAGS=$3
fi

export ROOT_HIST=0

for YEAR in $YEARS; do

  root-6.12 -l -q -b plot2.C+\(\"Wgg"$YEAR"_ele\",\"h_W_ele_nphotons\",\"$VERSION\",\"$FLAGS\"\)
  root-6.12 -l -q -b plot2.C+\(\"Wgg"$YEAR"_muo\",\"h_W_muo_nphotons\",\"$VERSION\",\"$FLAGS\"\)

  root-6.12 -l -q -b plot2.C+\(\"Zgg"$YEAR"_ele\",\"h_Z_ele_nphotons\",\"$VERSION\",\"$FLAGS\"\)
  root-6.12 -l -q -b plot2.C+\(\"Zgg"$YEAR"_muo\",\"h_Z_muo_nphotons\",\"$VERSION\",\"$FLAGS\"\)

done

exit