#!/bin/bash -x

if [ "$1" == "--version" ]; then
    echo 1
    exit 0
fi

die(){
    echo >&2 "$@"
    exit 1
}

source freesurfer5_setup.sh

MR_LABEL=$1

FS_ROOT_DIR=$2
if [ ! "`pwd`" == "$FS_ROOT_DIR" ]; then
    cd $FS_ROOT_DIR
fi

shift 2
FS_ARGS="$@"

if [ ! -h fsaverage ]; then
    ln -s ${FREESURFER_HOME}/subjects/fsaverage .
fi

recon-all -s $MR_LABEL -sd $FS_ROOT_DIR $FS_ARGS || die "recon-all failed"

pushd $MR_LABEL/mri
talairach_avi --i nu.mgz --xfm transforms/talairach.xfm || die "talairach_avi failed"
recon-all -s $MR_LABEL -sd $FS_ROOT_DIR -segstats || die "recon-all failed"
recon-all -s $MR_LABEL -sd $FS_ROOT_DIR -wmparc || die "recon-all failed"
popd

rm -rf *average*
export SUBJECTS_DIR=$FS_ROOT_DIR
kvlQuantifyHippocampalSubfieldSegmentations.sh || die "Calculating hippocampal subfield stats failed"

if [ ! -d "$MR_LABEL/mri/hippo-subfield-results" ]; then
    mkdir $MR_LABEL/mri/hippo-subfield-results
fi

mv non*.txt $MR_LABEL/mri/hippo-subfield-results
