#!/bin/tcsh -f

cd $SUBJECTS_DIR
setenv SUBJECT_NAME $1

if (-e $1/mri/brainmask.mgz) tkmedit $1 brainmask.mgz -tcl $RECON_CHECKER_SCRIPTS/snap_tkmedit.tcl
