#!/bin/bash -xe

VERSION=1

if [ "${1}" == "-version" ] ||  [ "${1}" == "--version" ] || [ "${1}" == "-v" ] ; then
    echo $VERSION
    exit 0
fi

FS_VERSION=$1
SUBJECTS_DIR=$2
shift 2
ARGS="$@"

case $FS_VERSION in
    5.1)
    SETUP=freesurfer5_setup.sh
    ;;
    5.3-HCP)
    SETUP=freesurfer53-HCP_setup.sh
    ;;
    5.3-HCP-patch)
    SETUP=freesurfer53-patch_setup.sh
    ;;
    *)
    echo "I don't recognize FreeSurfer version $FS_VERSION"
    exit 1
    ;;
esac

source $SETUP
export SUBJECTS_DIR
$FREESURFER_HOME/bin/asegstats2table $ARGS
