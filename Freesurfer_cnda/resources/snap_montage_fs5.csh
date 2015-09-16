#!/bin/tcsh -f

#Author: Mohana Ramaratnam
#This script will generate the gif snapshots of
#brainmask.mgz, wm.mgz, T1.mgz and aseg.mgz
#for a subject.
#
#Depends on a TCL script to generate the appropriate slices

set me=$0:t

if ($# == 0) then
    goto USAGE
endif

goto Start

##############################################
USAGE:
    echo "$me <subjectid> [<Path to subjects directory>]"
    echo "This script creates the snapshot images of the aseg, brainmask, T1 and wm volumes."
    echo "Defaults to environmental variable SUBJECTS_DIR "
    echo "Prerequisites: Needs FREESURFER_HOME environment variable to be set"
    exit
##############################################


Start:

source $SCRIPTS_HOME/freesurfer5_setup.csh
source $SCRIPTS_HOME/ImageMagick_setup.csh


set program = $0; set program_path = $program:h
set RECON_CHECKER_SCRIPTS = $program_path
setenv RECON_CHECKER_SCRIPTS $program_path

echo RECON_CHECKER_SCRIPTS set to $RECON_CHECKER_SCRIPTS

set subject = $1
set subjects_dir = $SUBJECTS_DIR

if ($# == 2) then
    set subjects_dir = $2
endif

setenv SUBJECTS_DIR $subjects_dir


cd $subjects_dir


set spath = $subjects_dir/$subject


if (! -e $subjects_dir/$subject/snapshots) then
    mkdir -p $subjects_dir/$subject/snapshots
endif

if ( -e "$spath/mri/brainmask.mgz" ) then
    setenv PREFIX brnmsk
    setenv LOADOTHERS 0
    setenv ASEG 0
    setenv APARC_ASEG 0
    tkmedit $subject brainmask.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
endif


if ( -e "$spath/mri/T1.mgz" ) then
    setenv PREFIX t1
    setenv LOADOTHERS 1
    setenv ASEG 0
    setenv APARC_ASEG 0
    tkmedit $subject T1.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
endif

if ( -e "$spath/mri/t1.mgz" ) then
    setenv PREFIX t1
    setenv LOADOTHERS 1
    setenv ASEG 0
    setenv APARC_ASEG 0
    tkmedit $subject t1.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
endif


if ( -e "$spath/mri/wm.mgz" ) then
    setenv PREFIX wm
    setenv LOADOTHERS 0
    setenv ASEG 0
    setenv APARC_ASEG 0
    tkmedit $subject wm.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
endif

if ( -e "$spath/mri/aseg.mgz" ) then
    setenv PREFIX aseg
    setenv LOADOTHERS 0
    setenv ASEG 1
    setenv APARC_ASEG 0
    tkmedit $subject brainmask.mgz  -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
endif

if ( -e "$spath/mri/orig.mgz" ) then
    setenv PREFIX aparc_aseg
    setenv LOADOTHERS 0
    setenv APARC_ASEG 1
    setenv ASEG 0
    tkmedit $subject orig.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_montage_fs5.tcl
endif

#Create gif and delete the rgb files

pushd $spath/snapshots
    if (`ls | egrep -c "\.rgb"`) then
        foreach f (*.rgb)
            convert -scale 300x300 $f ${f:r}.gif
            rm $f
        end
    endif
popd


echo "$me all done"

exit 0;
