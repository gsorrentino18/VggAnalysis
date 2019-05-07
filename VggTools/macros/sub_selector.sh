#!/bin/sh

QUEUE=normal
export USE_LSF_STARTER=no

EXCLUDED_HOSTS=""
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm003 && hname!=farm004 && hname!=farm005 && hname!=farm006 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm019 && hname!=farm020 && hname!=farm021 && hname!=farm022 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm045 && hname!=farm046 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm025 && hname!=farm026 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm073 && hname!=farm074 && hname!=farm075 && hname!=farm076 && "
EXCLUDED_HOSTS=$EXCLUDED_HOSTS"hname!=farm061 && hname!=farm062 && hname!=farm063 && hname!=farm064"

WORKDIR=/home/$USER/work/cms/VggAnalysis/VggTools/macros
cd $WORKDIR

VERSION="v10"

if [ ! -z "$1" ]; then
  VERSION=$1
fi

FLAGS="reference"

if [ ! -z "$2" ]; then
  FLAGS=$2
fi

LISTS=`ls lists/`

if [ ! -z "$3" ]; then
  if [ "$3" == "DT16" ]; then
    LISTS=`ls lists/ | grep Run2016`
  elif [ "$3" == "DT17" ]; then
    LISTS=`ls lists/ | grep Run2017`
  elif [ "$3" == "DT18" ]; then
    LISTS=`ls lists/ | grep Run2018`
  elif [ "$3" == "MC16" ]; then
    LISTS=`ls lists/ | grep RunIISummer16NanoAOD`
  elif [ "$3" == "MC17" ]; then
    LISTS=`ls lists/ | grep RunIIFall17NanoAOD`
  elif [ "$3" == "MC18" ]; then
    LISTS=`ls lists/ | grep 'RunIIAutumn18NanoAOD'`
  elif [ "$3" == "2016" ]; then
    LISTS=`ls lists/ | grep 'Run2016\|RunIISummer16NanoAOD'`
  elif [ "$3" == "2017" ]; then
    LISTS=`ls lists/ | grep 'Run2017\|RunIIFall17NanoAOD'`
  elif [ "$3" == "2018" ]; then
    LISTS=`ls lists/ | grep 'Run2018\|RunIIAutumn18NanoAOD'`
  else
    LISTS=$3
  fi
fi

./compile.sh mainSelector

mkdir -p data/$VERSION

cp -pv mainSelector.[hC] data/$VERSION/

for L in $LISTS; do
  L=`basename $L .list`.list
  if [ ! -e lists/$L ]; then
    echo "ERROR: missing file "lists/$L
    continue
  fi
  for FLAG in $FLAGS; do
    mkdir -p data/$VERSION/$FLAG
    bsub -q $QUEUE -R "$EXCLUDED_HOSTS" -J $L -e /dev/null -o /dev/null $WORKDIR/job_selector.sh $VERSION lists/$L $FLAG
  done
done

exit
