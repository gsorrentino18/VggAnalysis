#!/bin/sh

QUEUE=normal_io
export USE_LSF_STARTER=no

EXCLUDED_HOSTS=""
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm003 && hname!=farm004 && hname!=farm005 && hname!=farm006 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm019 && hname!=farm020 && hname!=farm021 && hname!=farm022 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm025 && hname!=farm026 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm045 && hname!=farm046 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm061 && hname!=farm062 && hname!=farm063 && hname!=farm064 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm073 && hname!=farm074 && hname!=farm075 && hname!=farm076"

WORKDIR=$HOME/work/cms/VggAnalysis/VggTools/skim
cd $WORKDIR

DATADIR=/eos/infnts/cms/store/data

for F in `eos find -f $DATADIR/ | grep Run2016 | grep NANOAOD | grep 25Oct2019`; do
  if [ -s $F ]; then
    if [ ! -e logs/`basename $F .root`_Skim.log ]; then
      touch logs/`basename $F .root`_Skim.log
      eos mkdir -p `dirname $F | sed -e 's;data;user/dellaric/data;'`
      bsub -q $QUEUE -R "$EXCLUDED_HOSTS" -e /dev/null -o /dev/null job_data_skim.sh $F
    fi
  fi
done

for F in `eos find -f $DATADIR/ | grep Run2017 | grep NANOAOD | grep 25Oct2019`; do
  if [ -s $F ]; then
    if [ ! -e logs/`basename $F .root`_Skim.log ]; then
      touch logs/`basename $F .root`_Skim.log
      eos mkdir -p `dirname $F | sed -e 's;data;user/dellaric/data;'`
      bsub -q $QUEUE -R "$EXCLUDED_HOSTS" -e /dev/null -o /dev/null job_data_skim.sh $F
    fi
  fi
done

for F in `eos find -f $DATADIR/ | grep Run2018 | grep NANOAOD | grep 25Oct2019`; do
  if [ -s $F ]; then
    if [ ! -e logs/`basename $F .root`_Skim.log ]; then
      touch logs/`basename $F .root`_Skim.log
      eos mkdir -p `dirname $F | sed -e 's;data;user/dellaric/data;'`
      bsub -q $QUEUE -R "$EXCLUDED_HOSTS" -e /dev/null -o /dev/null job_data_skim.sh $F
    fi
  fi
done

exit
