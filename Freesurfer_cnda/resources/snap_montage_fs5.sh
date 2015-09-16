#!/bin/sh 

me=$0
n=$#
USAGE="
USAGE: $me <subjectid> [<Path to subjects directory>]
       This script creates the snapshot images of the aseg, brainmask, T1 and wm volumes.
       Defaults to environmental variable SUBJECTS_DIR 
       Prerequisites: Needs FREESURFER_HOME environment variable to be set
"
	
if [ "$n" == "0" ] 
then
 echo $USAGE
 exit 1
fi



if [ ! -n "$RECON_CHECKER_SCRIPTS" ]
then
  if [ ! -n "$FREESURFER_HOME" ] 
  then
   echo "$me need RECON_CHECKER_SCRIPTS or FREESURFER_HOME env var set"
   exit  1
  else 
     export RECON_CHECKER_SCRIPTS=$FREESURFER_HOME/QATools/data_checker
  fi
fi


subject="$1"
subjects_dir=$SUBJECTS_DIR

if [ "$n" == "2" ]
then 
  subjects_dir="$2"
fi

export SUBJECTS_DIR=$subjects_dir
export DISPLAY=nrglin7:0.0

cd $subjects_dir


spath=$subjects_dir/$subject



if [ ! -e "$spath/snaps" ]
then
  mkdir -p $spath/snaps
fi

if [ -e "$spath/mri/brainmask.mgz" ]
then
 export PREFIX=brnmsk
 export LOADOTHERS=0
 tkmedit $subject brainmask.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
fi


if [ -e "$spath/mri/T1.mgz" ] 
then
 export PREFIX=t1
 export LOADOTHERS=1
 tkmedit $subject T1.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
fi

if [ -e "$spath/mri/wm.mgz" ]
then
  export PREFIX=wm
  export LOADOTHERS=0
 tkmedit $subject wm.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
fi

if [ -e "$spath/mri/aseg.mgz" ]
then
  export PREFIX=aseg
  export LOADOTHERS=0
 tkmedit $subject aseg.mgz $FREESURFER_HOME/FreeSurferColorLUT.txt -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
fi

#Create gif and delete the rgb files

pushd $spath/snaps
  if [ `ls | egrep -c "\.rgb"` ]
  then
    for f in *.rgb
    do 
       convert -scale 300x300 $f ${f:r}.gif
       rm $f
    done 
  fi
popd

echo "$me all done"
