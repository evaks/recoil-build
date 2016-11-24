#!/bin/bash

EXE=`which $0`
DIR=`dirname $EXE`

cd $DIR/..
fixjsstyle --disable 0110,0120 `find recoil/src/ -name "*.js" -and -not -name "*_test.js" `
#echo $DIR
#gjslint --disable 0110,0120 `ls *.js | grep -v _test.js`
