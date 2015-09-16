#!/bin/bash -xe

VERSION=1

die(){
    echo >&2 "$@"
    exit 1
}


# Give pipeline engine the version when it asks for it
if [ "${1}" == "-version" ] ||  [ "${1}" == "--version" ] || [ "${1}" == "-v" ] ; then
    echo $VERSION
    exit 0
fi

# Get input args
FS_VERSION=$1
PARAMS_FILE=$2

# Determine FS setup script from FS version
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
    die "I don't recognize FreeSurfer version $FS_VERSION"
    ;;
esac

# source params we need from bash params file.
source $PARAMS_FILE || die "Could not source params file $PARAMS_FILE"

# Construct recon-all args from params
RECON_ALL_ARGS="-s $label -sd $freesurferdir $recon_all_args"

# If we are relaunching FS, we are done. If not, we need to figure out our input files.
if [[ $relaunch != "true" ]]; then

    for t1 in ${scan_ids[*]}; do
        scan_file=`ls ${rawdir}/$t1 | head -1`
        # if [[ -z $scan_file ]]; then
        #     die "Could not find a file in directory ${rawdir}/$t1"
        # fi
        RECON_ALL_ARGS="$RECON_ALL_ARGS -i ${rawdir}/${t1}/$scan_file"
    done

    for t2 in ${T2_ids[*]}; do
        scan_file=`ls ${rawdir}/$t2 | head -1`
        # if [[ -z $scan_file ]]; then
        #     die "Could not find a file in directory ${rawdir}/$t2"
        # fi
        RECON_ALL_ARGS="$RECON_ALL_ARGS -T2 ${rawdir}/${t2}/$scan_file"
    done

    for flair in ${FLAIR_ids[*]}; do
        scan_file=`ls ${rawdir}/$flair | head -1`
        # if [[ -z $scan_file ]]; then
        #     die "Could not find a file in directory ${rawdir}/$flair"
        # fi
        RECON_ALL_ARGS="$RECON_ALL_ARGS -FLAIR ${rawdir}/${flair}/$scan_file"
    done
fi

# Set up Freesurfer
source $SETUP || die "Could not source setup script $SETUP"

$FREESURFER_HOME/bin/recon-all $RECON_ALL_ARGS || die "recon-all failed"
