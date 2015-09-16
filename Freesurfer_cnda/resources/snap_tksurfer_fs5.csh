#!/bin/tcsh -f
set me=$0:t


if (! ${?RECON_CHECKER_SCRIPTS}) then
  if (! ${?FREESURFER_HOME}) then
   echo "$me need RECON_CHECKER_SCRIPTS or FREESURFER_HOME env var set"
   exit  
  else 
     setenv RECON_CHECKER_SCRIPTS $FREESURFER_HOME/QAtools/data_checker
  endif
endif

set subject = $1
set subjects_dir = $SUBJECTS_DIR

if ($# == 2) then 
  set subjects_dir = $2
endif

setenv SUBJECTS_DIR $subjects_dir
setenv SUBJECT_NAME $subject
setenv doublebufferflag 1

cd $subjects_dir


set spath = $subjects_dir/$subject


if (! -e $spath/snaps) then
  mkdir -p $spath/snaps
endif

  foreach h (rh lh)
        tksurfer $1 $h inflated -tcl $RECON_CHECKER_SCRIPTS/snap_tksurfer_fs5.tcl
  end

#Create gif and delete the rgb files

pushd $spath/snaps
  if (`ls | egrep -c "\.rgb"`) then
    foreach f (*.rgb)
       convert -scale 300x300 $f ${f:r}.gif
       rm $f
    end 
  endif
popd

echo "$me all done"


