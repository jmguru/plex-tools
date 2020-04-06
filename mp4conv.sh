#!/bin/bash

usage () {
  echo 'Usage: mp4conv.sh -v|--videodir <PATH>'
  echo 'Example:'
  echo 'mp4conv.sh -v /Volumes/Secondary/convert'
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

for arg in "$@"
do
    case $arg in
        -v|--videodir)
        VIDEODIR="$2"
        shift
        shift
        ;;
        -h|--help)
        usage
        exit
        ;;
    esac
done

# Check if all the variables are defined
if [ -z ${VIDEODIR+x} ]; then
   usage
   exit 1
fi

for f in $VIDEODIR/*
do
   basenm=$(basename -- "$f")
   nm_noext=${basenm::${#basenm}-4}
   nfile=$VIDEODIR/$nm_noext.mp4
   ffmpeg -i $f -codec copy -map 0:a -map 0:v $nfile 
done
