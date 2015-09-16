function segmentation(input_nifti)
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

spm_home='/usr/local/MATLAB/spm12b';
toolsnifti_home='/usr/local/MATLAB/ToolsNifti';

path(pathdef)
addpath(spm_home);
addpath(toolsnifti_home);
fileNii={strtrim(input_nifti)};
[PATHSTR,NAME,EXT] = fileparts(strtrim(input_nifti));

spm_jobman('initcfg');
matlabbatch{1}.spm.spatial.preproc.channel.vols = fileNii;
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 100;
matlabbatch{1}.spm.spatial.preproc.channel.write = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {strcat(spm_home,'/tpm/TPM.nii,1')};
matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {strcat(spm_home,'/tpm/TPM.nii,2')};
matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {strcat(spm_home,'/tpm/TPM.nii,3')};
matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {strcat(spm_home,'/tpm/TPM.nii,4')};
matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {strcat(spm_home,'/tpm/TPM.nii,5')};
matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {strcat(spm_home,'/tpm/TPM.nii,6')};
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

matlabbatch{2}.spm.spatial.normalise.write.subj.def = {fullfile(PATHSTR,strcat('y_',NAME,EXT))};
matlabbatch{2}.spm.spatial.normalise.write.subj.resample = fileNii;
matlabbatch{2}.spm.spatial.normalise.write.woptions.bb = [-90 -127 -73
                                                          91 90 108];
matlabbatch{2}.spm.spatial.normalise.write.woptions.vox = [1 1 1];
matlabbatch{2}.spm.spatial.normalise.write.woptions.interp = 4;

% save('batch_vbm.mat','matlabbatch');
spm_jobman('run',matlabbatch);

mwc1=load_nii(strcat(PATHSTR,'/mwc1',NAME,EXT));
mwc2=load_nii(strcat(PATHSTR,'/mwc3',NAME,EXT));
mwc3=load_nii(strcat(PATHSTR,'/mwc3',NAME,EXT));

GM_V=nnz(mwc1.img)*prod(matlabbatch{2}.spm.spatial.normalise.write.woptions.vox)/1000 % Divided by 1000 to convert from mm3 to cm3
WM_V=nnz(mwc2.img)*prod(matlabbatch{2}.spm.spatial.normalise.write.woptions.vox)/1000 % Divided by 1000 to convert from mm3 to cm3
CSF_V=nnz(mwc3.img)*prod(matlabbatch{2}.spm.spatial.normalise.write.woptions.vox)/1000 % Divided by 1000 to convert from mm3 to cm3

fid = fopen(strcat(PATHSTR,'/vol.xml'),'w');
fprintf(fid,'<vbm:vbmAssessorData xmlns:xnat="http://nrg.wustl.edu/xnat" xmlns:vbm="http://nrg.wustl.edu/vbm" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">\n');
fprintf(fid,'\t<vbm:GM_Volume>%.2f</vbm:GM_Volume>\n',GM_V);
fprintf(fid,'\t<vbm:WM_Volume>%.2f</vbm:WM_Volume>\n',WM_V);
fprintf(fid,'\t<vbm:CSF_Volume>%.2f</vbm:CSF_Volume>\n',CSF_V);
fprintf(fid,'\t<vbm:Modulated>1</vbm:Modulated>\n');
fprintf(fid,'\t<vbm:Smoothing>8</vbm:Smoothing>\n');
fprintf(fid,'\t<vbm:StereotaxicSpace>MNI</vbm:StereotaxicSpace>\n');
fprintf(fid,'\t<vbm:AlgoTissClass>Spm12b</vbm:AlgoTissClass>\n');
fprintf(fid,'\t<vbm:AlgoNorm>Spm12b</vbm:AlgoNorm>\n');
fprintf(fid,'\t<vbm:baseScanNumber>2</vbm:baseScanNumber>\n');
fprintf(fid,'\t<vbm:WorkFlowID>NoID</vbm:WorkFlowID>\n');
fprintf(fid,'</vbm:vbmAssessorData>');
fclose(fid);
