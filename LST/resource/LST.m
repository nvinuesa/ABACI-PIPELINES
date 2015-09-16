function LST(input_t1,input_flair)
%LST   Function to apply LST.
%   Use this function with the LST pipeline on the ABACI project.
%   Outputs all the segmented images and a .xml file that can be
%   later uploaded to the ABACI XNAT version.
%
%   Syntax: LST(input_t1,input_flair);
%
%   Inputs:
%       input_t1    - Input T1 nifti file.
%       input_flair - Input FLAIR nifti file.

%   Author: Nicolas Vinuesa
%   GIN, UMR 5296 - www.gin.cnrs.fr
%   Date: 11/03/2014, Rev.: 1

spm_home='/usr/local/MATLAB/spm12b';
toolsnifti_home='/usr/local/MATLAB/ToolsNifti';

path(pathdef)
addpath(spm_home);
addpath(toolsnifti_home);

t1={strtrim(input_t1)};
flair={strtrim(input_flair)};

spm_jobman('initcfg');
matlabbatch{1}.spm.tools.LST.lesiongrow.data_T1 = t1;
matlabbatch{1}.spm.tools.LST.lesiongrow.data_FLAIR = flair;
matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.initial = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];
matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.belief = 0;
matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.mrf = 1;
matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.maxiter = 50;
matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.threshold = 0;
matlabbatch{1}.spm.tools.LST.lesiongrow.output.lesions.prob = 1;
matlabbatch{1}.spm.tools.LST.lesiongrow.output.lesions.binary = 1;
matlabbatch{1}.spm.tools.LST.lesiongrow.output.lesions.normalized = 1;
matlabbatch{1}.spm.tools.LST.lesiongrow.output.other = 1;
spm_jobman('run',matlabbatch);


