#!/bin/bash

# version 2021-08-07 15:20

cd ~/dockerwatermeter

if [ -n "$1" ]; then
  ex=$1
else
  rc=$(git remote show origin |  grep "local out of date" | wc -l)
  if [ $rc -ne "0" ]; then
    ex=true
  else
    ex=false
  fi
fi

if [ $ex == true ]; then
    git pull
    chmod +x build.sh

    docker image build -t revenberg/watermeter:latest .

    docker push revenberg/watermeter:latest

    # testing: 

    echo "==========================================================="
    echo "=                                                         ="
    echo "=          docker run revenberg/watermeter                ="
    echo "=                                                         ="
    echo "==========================================================="
    # docker run revenberg/watermeter
fi

cd -
