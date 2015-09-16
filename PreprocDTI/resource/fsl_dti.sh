#!/bin/bash 

eddy_corrected=$2/out/eddy_$3.nii.gz
fsl4.1-eddy_correct $1 $eddy_corrected 0
maskString='_mask'
masked=$2/out/b0_$3$maskString.nii.gz
fsl4.1-bet $eddy_corrected $masked -m -R -f 0.35
bvec=$2/BVEC/$3.bvec
bval=$2/BVAL/$3.bval
fsl4.1-dtifit -k $eddy_corrected -m $masked -r $bvec -b $bval -o $2/out/$3

