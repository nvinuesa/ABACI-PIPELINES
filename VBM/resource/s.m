function segmentation(input_nifti,output_niftis)

path(pathdef)
addpath(genpath('/homes_unix/ginius/matlab/spm12b/'))
addpath /homes_unix/ginius/matlab/ToolsNifti/
fileNii={strtrim(input_nifti)};
[PATHSTR,NAME,EXT] = fileparts(strtrim(input_nifti));

spm_jobman('initcfg');
matlabbatch{1}.spm.spatial.preproc.channel.vols = fileNii;
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 100;
matlabbatch{1}.spm.spatial.preproc.channel.write = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {'/homes_unix/ginius/matlab/spm12b/tpm/TPM.nii,1'};
matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {'/homes_unix/ginius/matlab/spm12b/tpm/TPM.nii,2'};
matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {'/homes_unix/ginius/matlab/spm12b/tpm/TPM.nii,3'};
matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [1 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {'/homes_unix/ginius/matlab/spm12b/tpm/TPM.nii,4'};
matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {'/homes_unix/ginius/matlab/spm12b/tpm/TPM.nii,5'};
matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {'/homes_unix/ginius/matlab/spm12b/tpm/TPM.nii,6'};
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

save('batch_vbm.mat','matlabbatch');
spm_jobman('run',matlabbatch);

mwc1=load_nii(strcat('mwc1',NAME,EXT));
mwc2=load_nii(strcat('mwc3',NAME,EXT));
mwc3=load_nii(strcat('mwc3',NAME,EXT));

GM_V=nnz(mwc1.img)*prod(matlabbatch{2}.spm.spatial.normalise.write.woptions.vox);
WM_V=nnz(mwc2.img)*prod(matlabbatch{2}.spm.spatial.normalise.write.woptions.vox);
CSF_V=nnz(mwc3.img)*prod(matlabbatch{2}.spm.spatial.normalise.write.woptions.vox);

fid = fopen('volume.txt','w');
fprintf(fid,'Grey matter volume: %.2f cmm3 \n',GM_V/1000); % Divided by 1000 to convert from mm3 to cm3
fprintf(fid,'White matter volume: %.2f cmm3 \n',WM_V/1000); % Divided by 1000 to convert from mm3 to cm3
fprintf(fid,'Cerebrospinal fluid (CSF) volume: %.2f cmm3 \n',CSF_V/1000); % Divided by 1000 to convert from mm3 to cm3
fclose(fid);



