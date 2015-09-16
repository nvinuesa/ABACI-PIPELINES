#!/bin/bash -x

if [ "$1" == "--version" ]; then
    echo 3
    exit 0
fi

die(){
    echo >&2 "$@"
    exit 1
}

INPUT_DIR=$1
FORMAT=$2
SETUP_SCRIPT=$3

source $SETUP_SCRIPT || die "Could not source setup script $SETUP_SCRIPT"

echo $0 running from `pwd`
echo Input directory: $INPUT_DIR

if [[ "$FORMAT" == "DICOM" ]]; then
    echo "Attempting to convert DICOM input"
    INPUT_FILE=`find $INPUT_DIR -iname *.dcm | head -1`
    if [[ ! -e $INPUT_FILE ]]; then
        echo "Could not find a .dcm DICOM file in $INPUT_DIR. Looking for .ima."
        INPUT_FILE=`find $INPUT_DIR -iname *.ima | head -1`
    fi
    if [[ ! -e $INPUT_FILE ]]; then
        echo "Could not find a DICOM of type .dcm or .ima in $INPUT_DIR."
        echo "Grabbing any file. Hopefully this works..."
        INPUT_FILE=`ls -d 1 $INPUT_DIR/* | head -1`
    fi
    if [[ ! -e $INPUT_FILE ]]; then
        die "$INPUT_DIR is empty."
    fi
    INPUT_TYPE="dicom"
elif [[ "$FORMAT" == "NIFTI" ]]; then
    echo "Attempting to convert NIFTI input"
    INPUT_FILE=`find $INPUT_DIR -iregex '.*\.nii\(\.gz\)?'`
    if [[ ! -e $INPUT_FILE ]]; then
        echo "Could not find a .nii or .nii.gz NIFTI file in $INPUT_DIR. Looking for .img/.hdr pair."
        INPUT_FILE=`find $INPUT_DIR -iname *.img`
        if [[ ! -e $INPUT_FILE ]]; then
            die "Could not find an input file"
        else
            INPUT_TYPE="nifti1"
        fi
    else
        INPUT_TYPE="nii"
    fi
else
    die "Cannot convert input of format $FORMAT"
fi

if [[ ! -d mri/orig ]]; then
    echo mri/orig dir does not exist. Making directory.
    mkdir -p mri/orig
fi

count=1
fileid="00"$count

while [[ -e mri/orig/${fileid}.mgz ]]; do
    echo mri/orig/${fileid}.mgz exists
    ((count++))
    if (($count < 10 )); then
        fileid="00"$count
    elif (($count < 100)); then
        fileid="0"$count
    elif (($count < 1000)); then
        fileid=$count
    else
        die "All numbers under 1000 already used for file names in target directory"
    fi
done

echo mri/orig/${fileid}.mgz does not exist
echo Converting series including `basename $INPUT_FILE` to ${fileid}.mgz

$FREESURFER_HOME/bin/mri_convert -i $INPUT_FILE --in_type $INPUT_TYPE -o mri/orig/${fileid}.mgz
