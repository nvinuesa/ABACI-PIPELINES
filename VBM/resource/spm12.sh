#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
parentDir="$(dirname "$SCRIPTPATH")"
catalogDir="$(dirname "$parentDir")"
source $catalogDir/generic/sources.sh
run_spm12.sh $MCR_SPM12_HOME $@

