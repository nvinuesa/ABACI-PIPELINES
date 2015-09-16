function vbmMakeAssessor(input_nifti)
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

[PATHSTR,NAME,EXT] = fileparts(strtrim(input_nifti));

mwc1=load_nii(strcat(PATHSTR,'/mwc1',NAME,EXT));
mwc2=load_nii(strcat(PATHSTR,'/mwc2',NAME,EXT));
mwc3=load_nii(strcat(PATHSTR,'/mwc3',NAME,EXT));
rAAL=load_nii(strcat(PATHSTR,'/rAAL',EXT));

hippoL = rAAL.img;
hippoL(hippoL~=4101)=0;
hippoL(hippoL==4101)=1;
hippoR = rAAL.img;
hippoR(hippoR~=4102)=0;
hippoR(hippoR==4102)=1;

voxSize1 = mwc1.hdr.dime.pixdim(2:4);
voxSize2 = mwc2.hdr.dime.pixdim(2:4);
voxSize3 = mwc3.hdr.dime.pixdim(2:4);

GM_V = sum(sum(sum(mwc1.img)))*prod(voxSize1);
WM_V = sum(sum(sum(mwc2.img)))*prod(voxSize2);
CSF_V = sum(sum(sum(mwc3.img)))*prod(voxSize3);

hl = mwc1.img;  
hr = hl;
hl(hippoL~=1)=0;
hr(hippoR~=1)=0;
Hyp_L = sum(sum(sum(hl)))*prod(voxSize1);
Hyp_R = sum(sum(sum(hr)))*prod(voxSize1);

[~,version] = system('/usr/local/ABACI/xnat/pipeline/catalog/pipelines/VBM_VM/resource/runSpm/runSpm.sh version');
fid = fopen(strcat(PATHSTR,'/vol.xml'),'w');
fprintf(fid,'<vbm:vbmAssessorData xmlns:xnat="http://nrg.wustl.edu/xnat" xmlns:vbm="http://nrg.wustl.edu/vbm" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">\n');
fprintf(fid,'\t<vbm:GM_Volume>%.2f</vbm:GM_Volume>\n',GM_V);
fprintf(fid,'\t<vbm:WM_Volume>%.2f</vbm:WM_Volume>\n',WM_V);
fprintf(fid,'\t<vbm:CSF_Volume>%.2f</vbm:CSF_Volume>\n',CSF_V);
fprintf(fid,'\t<vbm:HYPL_Volume>%.2f</vbm:HYPL_Volume>\n',Hyp_L);
fprintf(fid,'\t<vbm:HYPR_Volume>%.2f</vbm:HYPR_Volume>\n',Hyp_R);
fprintf(fid,'\t<vbm:StereotaxicSpace>MNI</vbm:StereotaxicSpace>\n');
fprintf(fid,'\t<vbm:AlgoNorm>%s</vbm:AlgoNorm>\n',char(regexp(version,'^[^:]*','match')));
fprintf(fid,'\t<vbm:AtlasHyp>AAL for SPM 12 (http://www.gin.cnrs.fr/AAL-216)</vbm:AtlasHyp>\n');
fprintf(fid,'\t<vbm:baseScanNumber>%s</vbm:baseScanNumber>\n',NAME);
fprintf(fid,'</vbm:vbmAssessorData>');
fclose(fid);
