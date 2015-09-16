#!/bin/bash -x

FREESURFER_HOME=/usr/local/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

if [ "$1" == "--version" ]; then
    echo 1
    exit 0
fi

DICOM_FILE=$1

echo $0 running from `pwd`
echo Input DICOM file: $DICOM_FILE

if [ ! -d mri/orig ]; then
    echo mri/orig dir does not exist.
    echo mkdir -p mri/orig
    mkdir -p mri/orig
fi

count=1
fileid="00"$count

while [ -e mri/orig/${fileid}.mgz ]; do
    echo mri/orig/${fileid}.mgz exists
    count=$((count+1))
    if [ $count -lt 10 ]; then
        fileid="00"$count
    elif [ $count -lt 100 ]; then
        fileid="0"$count
    elif [ $count -lt 1000 ]; then
        fileid=$count
    fi
done

echo mri/orig/${fileid}.mgz does not exist
echo Converting DICOM series including `basename $DICOM_FILE` to ${fileid}.mgz

echo $FREESURFER_HOME
$FREESURFER_HOME/bin/mri_convert -i $DICOM_FILE -o mri/orig/${fileid}.mgz
