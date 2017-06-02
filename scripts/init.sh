#!/bin/bash
set -e
BASEDIR="$( cd "$( dirname "$0" )" && pwd )"
FILENAME=../../requestConfig.plist
cd $BASEDIR
# echo $BASEDIR
cd ../JVNetwork/strategy
BASEDIR=`pwd`
rm $FILENAME 2>/dev/null
touch $FILENAME
echo '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' >>$FILENAME
echo '<plist version="1.0"><array>' >>$FILENAME
for name in $( ls |grep \\.m |sed "s/\.m//g")
do
    echo '<dict>' >>$FILENAME
    echo '  <key>name</key><string>'${name}'</string>' >>$FILENAME
    echo '</dict>' >>$FILENAME
done
echo '</array></plist>' >>$FILENAME

echo 'ok'
