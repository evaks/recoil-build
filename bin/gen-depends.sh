#!/bin/bash
MAJOR=`python --version |& sed 's/Python //g' | sed 's/\.[0-9][0-9]*//g'`


if [ "$MAJOR" -gt 2 ] ; then
      if [ -z "$PYTHON2" ] ; then
      echo "Incorrect Python version, set PYTHON2 path to python executable"
      exit
      else
            PYTHON=$PYTHON2
      fi
else
       PYTHON=python
fi

DIR=`dirname $0`
cd ${DIR}/../
${PYTHON} closure-library/closure/bin/calcdeps.py -p closure-library -p recoil/src/  -o deps   > my-deps.js
