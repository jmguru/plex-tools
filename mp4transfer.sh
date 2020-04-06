#!/bin/bash

usage () {
  echo 'Usage: mp4transfer.sh -v|--videodir <PATH> -h|--host <IP/HOSTNAME> -t|--targetdir <PATH>'
  echo 'Example:'
  echo 'mp4transfer.sh -v /Volumes/Secondary/convert -h 192.168.1.121 -t /media/usb/tv'
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
        -h|--host)
        HOST="$2"
        shift
        shift
        ;;
        -t|--targetdir)
        TARGETDIR="$2"
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
if [ -z ${VIDEODIR+x} ] || [ -z ${HOST+x} ] || [ -z ${TARGETDIR+x} ]; then
   usage
   exit 1
fi

for f in $VIDEODIR/*.mp4
do
  scp $f pi@$HOST:$TARGETDIR
done
