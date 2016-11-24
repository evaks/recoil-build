#!/bin/bash
MAJOR=`python --version |& sed 's/Python //g' | sed 's/\.[0-9][0-9]*//g'`
#java -jar compiler.jar --js shop.js --js icecream.js --js cone.js
if [ "$MAJOR" -gt 2 ] ; then
      if [ -z "$PYTHON2" ] ; then
      echo "Incorrect Python version, set PYTHON2 path to python executable"
      exit
      else
            PYTHON=$PYTHON2
      fi
else
    if [ -z "$PYTHON2" ] ; then
	PYTHON=python
    else
        PYTHON=$PYTHON2
    fi
fi

DIR=`dirname $0`
cd ${DIR}/..

gjslint --disable 0110,0120 `find recoil/src -name "*.js" -and -not -name "*_test.js" `
if [ $? -ne 0 ]; then
    echo Error Occured in Lint stopping compile
    exit 2
fi



${PYTHON} closure-library/closure/bin/build/closurebuilder.py --root closure-library/ --root recoil/src/ --compiler_flags="--compilation_level=ADVANCED_OPTIMIZATIONS" --compiler_flags="--warning_level=VERBOSE" \
    --compiler_flags="--jscomp_error=checkTypes" \
    -c bin/compiler.jar  --output_mode="compiled"  `grep -hr --include="*.js" --exclude="*_test.js" goog.provide  recoil/src  | sed 's/goog.provide('\'// | sed s/\'');.*$'// | sort|uniq | sed s/^/--namespace\ /` > /dev/null

#${PYTHON} closure-library/closure/bin/build/closurebuilder.py --root closure-library/ --root lib/ --compiler_flags="--compilation_level=ADVANCED_OPTIMIZATIONS" --compiler_flags="--warning_level=VERBOSE --jscomp_error=checkTypes" -c compiler.jar  --output_mode="compiled"  `grep -hr --include="*.js" --exclude="*_test.js" goog.provide  lib  | sed 's/goog.provide('\'// | sed s/\'');'// | sort|uniq | sed s/^/--namespace\ /` > /dev/null

echo "Exit " $? 


