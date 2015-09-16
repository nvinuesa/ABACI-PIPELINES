function vbmMakeBatch(workdir,input_nifti,template)
%segmentation   Function to apply VBM on spm12b to a nifti file.
%   Use this function with the VBM pipeline on the ABACI project.
%   Outputs all the segmented images and a .xml file that can be
%   later uploaded to the ABACI XNAT version.
%
%   Syntax: segmentation(input_nifti);
%
%   Inputs:
%       input_nifti   - Input nifti file.

%   Author: Nicolas Vinuesa
%   GIN, UMR 5296 - www.gin.cnrs.fr
%   Date: 11/03/2014, Rev.: 1

fileNii={strtrim(input_nifti)};
[PATHSTR,NAME,EXT] = fileparts(strtrim(input_nifti));
matlabbatch{1}.spm.spatial.preproc.channel.vols = fileNii;
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 100;
matlabbatch{1}.spm.spatial.preproc.channel.write = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {strcat(template,',1')};
matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {strcat(template,',2')};
matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {strcat(template,',3')};
matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {strcat(template,',4')};
matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {strcat(template,',5')};
matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {strcat(template,',6')};
matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{1}.spm.spatial.preproc.warp.write = [1 1];

tm = load_untouch_nii(template);

matlabbatch{2}.spm.spatial.normalise.write.subj.def = {fullfile(PATHSTR,strcat('y_',NAME,EXT))};
matlabbatch{2}.spm.spatial.normalise.write.subj.resample = fileNii;
matlabbatch{2}.spm.spatial.normalise.write.woptions.bb = [-90 -127 -73
                                                          91 90 108];
matlabbatch{2}.spm.spatial.normalise.write.woptions.vox = tm.hdr.dime.pixdim(2:4);
matlabbatch{2}.spm.spatial.normalise.write.woptions.interp = 4;

copyfile(fullfile(ctfroot,'vbmMakeBatch','AAL.nii'),fullfile(PATHSTR,'AAL.nii'));

matlabbatch{3}.spm.spatial.coreg.estwrite.ref = {fullfile(PATHSTR,strcat('mwc1',NAME,EXT))};
matlabbatch{3}.spm.spatial.coreg.estwrite.source = {'AAL.nii'};
matlabbatch{3}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{3}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.interp = 0;
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{3}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

save(fullfile(workdir,'tmp','batch_vbm.mat'),'matlabbatch');