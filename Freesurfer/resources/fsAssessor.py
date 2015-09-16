#! /usr/bin/python

# Copyright (C) 2014 nicolasvinuesa
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

__author__="Nicolas Vinuesa"
__date__ ="$Apr 4, 2014 5:35:22 PM$"

from xml.etree.ElementTree import Element
import xml.etree.ElementTree as etree
import xml.dom.minidom
import re
import sys
import getopt

def main():
    try:
        o, a = getopt.getopt(sys.argv[1:], "hw:f:")
    except getopt.GetoptError as err:
        print err
        print 'fsAssessor.py -w <workdir> -f <freesurferdir>'
        sys.exit(2)
    if len(o) < 2:
        print 'fsAssessor.py -w <workdir> -f <freesurferdir>'
        sys.exit(2)
    for opt, arg in o:
        if opt == '-h':
            print 'fsAssessor.py -w <workdir> -f <freesurferdir>'
            sys.exit()
        elif opt == '-w':
            workdir = arg
        elif opt == '-f':
            freesurferdir = arg
    
    exp = '\d*\.?\d+' # regexp for float numbers
    f = open(freesurferdir + '/stats/aseg.stats','r');
    for i, line in enumerate(f):
        if i == 16:
	    gm_L_volCortex = float(re.findall(exp,line)[0]) # cast list of strings to float            
        elif i == 17:
            gm_R_volCortex = float(re.findall(exp,line)[0])
	elif i == 18:
   	    gm_T_volCortex = float(re.findall(exp,line)[0])	
	elif i == 19:
   	    wm_L_hemis = float(re.findall(exp,line)[0])	    
	elif i == 20:
   	    wm_R_hemis = float(re.findall(exp,line)[0])	
	elif i == 33:
   	    icv = float(re.findall(exp,line)[0])	
	elif i == 79:
   	    ventricle1 = float(re.findall(exp,line)[3])
	elif i == 80:
   	    ventricle2 = float(re.findall(exp,line)[3])
	elif i == 97:
   	    ventricle3 = float(re.findall(exp,line)[3])
	elif i == 98:
   	    ventricle4 = float(re.findall(exp,line)[3])
	elif i == 87:
   	    ventricle5 = float(re.findall(exp,line)[3])
	elif i == 88:
   	    ventricle6 = float(re.findall(exp,line)[3])
	elif i == 111:
   	    ventricle7 = float(re.findall(exp,line)[3])
	elif i == 82:
   	    gm_L_volCerebellum = float(re.findall(exp,line)[3])
	elif i == 100:
   	    gm_R_volCerebellum = float(re.findall(exp,line)[3])
	elif i == 81:
   	    wm_L_volCerebellum = float(re.findall(exp,line)[3])
	elif i == 99:
   	    wm_R_volCerebellum = float(re.findall(exp,line)[3])
	elif i == 83:
   	    gm_L_nucleus1 = float(re.findall(exp,line)[3])
	elif i == 84:
   	    gm_L_nucleus2 = float(re.findall(exp,line)[3])
	elif i == 85:
   	    gm_L_nucleus3 = float(re.findall(exp,line)[3])
	elif i == 86:
   	    gm_L_nucleus4 = float(re.findall(exp,line)[3])
	elif i == 93:
   	    gm_L_nucleus5 = float(re.findall(exp,line)[3])
	elif i == 94:
   	    gm_L_nucleus6 = float(re.findall(exp,line)[3])
	elif i == 101:
   	    gm_R_nucleus1 = float(re.findall(exp,line)[3])
	elif i == 102:
   	    gm_R_nucleus2 = float(re.findall(exp,line)[3])
	elif i == 103:
   	    gm_R_nucleus3 = float(re.findall(exp,line)[3])
	elif i == 104:
   	    gm_R_nucleus4 = float(re.findall(exp,line)[3])
	elif i == 107:
   	    gm_R_nucleus5 = float(re.findall(exp,line)[3])
	elif i == 108:
   	    gm_R_nucleus6 = float(re.findall(exp,line)[3])
	elif i == 119:
   	    cc1 = float(re.findall(exp,line)[3])
	elif i == 120:
   	    cc2 = float(re.findall(exp,line)[3])
	elif i == 121:
   	    cc3 = float(re.findall(exp,line)[3])
	elif i == 122:
   	    cc4 = float(re.findall(exp,line)[3])
	elif i == 123:
   	    cc5 = float(re.findall(exp,line)[3])
	elif i == 90:
   	    gm_L_hippo = float(re.findall(exp,line)[3])
	elif i == 105:
   	    gm_R_hippo = float(re.findall(exp,line)[3])
    f.close()
    exp = '\d*\.?\d+' # regexp for float numbers
    f = open(freesurferdir + '/stats/lh.aparc.stats','r');
    for i, line in enumerate(f):
	if i == 19:
	    gm_L_surface = float(re.findall(exp,line)[0])    
        elif i == 20:
            gm_L_ct = float(re.findall(exp,line)[0])
    f.close()
    f = open(freesurferdir + '/stats/rh.aparc.stats','r');
    for i, line in enumerate(f):
	if i == 19:
	    gm_R_surface = float(re.findall(exp,line)[0])         
        elif i == 20:
            gm_R_ct = float(re.findall(exp,line)[0])
    f.close()   

    gm_T_volCerebellum = gm_L_volCerebellum + gm_R_volCerebellum
    gm_L_volNucleus = gm_L_nucleus1 + gm_L_nucleus2 + gm_L_nucleus3 + gm_L_nucleus4 + gm_L_nucleus5 + gm_L_nucleus6
    gm_R_volNucleus = gm_R_nucleus1 + gm_R_nucleus2 + gm_R_nucleus3 + gm_R_nucleus4 + gm_R_nucleus5 + gm_R_nucleus6   
    gm_T_volNucleus = gm_L_volNucleus + gm_R_volNucleus
    gm_L_volHemisphere = gm_L_volCortex + gm_L_volNucleus
    gm_R_volHemisphere = gm_R_volCortex + gm_R_volNucleus
    gm_T_volHemisphere = gm_L_volHemisphere + gm_R_volHemisphere
    gm_L_vol = gm_L_volHemisphere + gm_L_volCerebellum
    gm_R_vol = gm_R_volHemisphere + gm_R_volCerebellum
    gm_T_vol = gm_L_vol + gm_R_vol
    gm_T_hippo = gm_L_hippo + gm_R_hippo
    gm_T_surface = gm_L_surface + gm_R_surface
    gm_T_ct = (gm_L_ct + gm_R_ct) / 2
    wm_T_hemis = wm_L_hemis + wm_R_hemis
    wm_T_volCerebellum = wm_L_volCerebellum + wm_R_volCerebellum
    wm_L_vol = wm_L_hemis + wm_L_volCerebellum
    wm_R_vol = wm_R_hemis + wm_R_volCerebellum    
    wm_T_vol = wm_L_vol + wm_R_vol
    wm_cc = cc1 + cc2 + cc3 + cc4 + cc5
    csf_ventricle = ventricle1 + ventricle2 + ventricle3 + ventricle4 + ventricle5 + ventricle6 + ventricle7
    
    fs = Element('freesurfer:fsAssessorData')
    fsVersion = etree.SubElement(fs, 'freesurfer:fs_version')
    fs_gm_L_volCortex = etree.SubElement(fs, 'freesurfer:gm_L_volCortex')
    fs_gm_R_volCortex = etree.SubElement(fs, 'freesurfer:gm_R_volCortex')
    fs_gm_T_volCortex = etree.SubElement(fs, 'freesurfer:gm_T_volCortex')
    fs_gm_L_volCerebellum = etree.SubElement(fs, 'freesurfer:gm_L_volCerebellum')
    fs_gm_R_volCerebellum = etree.SubElement(fs, 'freesurfer:gm_R_volCerebellum')
    fs_gm_T_volCerebellum = etree.SubElement(fs, 'freesurfer:gm_T_volCerebellum')
    fs_gm_L_volNucleus = etree.SubElement(fs, 'freesurfer:gm_L_volNucleus')
    fs_gm_R_volNucleus = etree.SubElement(fs, 'freesurfer:gm_R_volNucleus')
    fs_gm_T_volNucleus = etree.SubElement(fs, 'freesurfer:gm_T_volNucleus')
    fs_gm_L_volHemisphere = etree.SubElement(fs, 'freesurfer:gm_L_volHemisphere')
    fs_gm_R_volHemisphere = etree.SubElement(fs, 'freesurfer:gm_R_volHemisphere')
    fs_gm_T_volHemisphere = etree.SubElement(fs, 'freesurfer:gm_T_volHemisphere')
    fs_gm_L_vol = etree.SubElement(fs, 'freesurfer:gm_L_vol')
    fs_gm_R_vol = etree.SubElement(fs, 'freesurfer:gm_R_vol')
    fs_gm_T_vol = etree.SubElement(fs, 'freesurfer:gm_T_vol')
    fs_gm_L_hippo = etree.SubElement(fs, 'freesurfer:gm_L_hippo')
    fs_gm_R_hippo = etree.SubElement(fs, 'freesurfer:gm_R_hippo')
    fs_gm_T_hippo = etree.SubElement(fs, 'freesurfer:gm_T_hippo')
    fs_gm_L_surface = etree.SubElement(fs, 'freesurfer:gm_L_surface')
    fs_gm_R_surface = etree.SubElement(fs, 'freesurfer:gm_R_surface')
    fs_gm_T_surface = etree.SubElement(fs, 'freesurfer:gm_T_surface')
    fs_gm_L_ct = etree.SubElement(fs, 'freesurfer:gm_L_ct')
    fs_gm_R_ct = etree.SubElement(fs, 'freesurfer:gm_R_ct')
    fs_gm_T_ct = etree.SubElement(fs, 'freesurfer:gm_T_ct')
    fs_wm_L_hemis = etree.SubElement(fs, 'freesurfer:wm_L_hemis')
    fs_wm_R_hemis = etree.SubElement(fs, 'freesurfer:wm_R_hemis')
    fs_wm_T_hemis = etree.SubElement(fs, 'freesurfer:wm_T_hemis')
    fs_wm_L_volCerebellum = etree.SubElement(fs, 'freesurfer:wm_L_volCerebellum')
    fs_wm_R_volCerebellum = etree.SubElement(fs, 'freesurfer:wm_R_volCerebellum')
    fs_wm_T_volCerebellum = etree.SubElement(fs, 'freesurfer:wm_T_volCerebellum')
    fs_wm_L_vol = etree.SubElement(fs, 'freesurfer:wm_L_vol')
    fs_wm_R_vol = etree.SubElement(fs, 'freesurfer:wm_R_vol')
    fs_wm_T_vol = etree.SubElement(fs, 'freesurfer:wm_T_vol')
    fs_wm_cc = etree.SubElement(fs, 'freesurfer:wm_cc')
    fs_csf_ventricle = etree.SubElement(fs, 'freesurfer:csf_ventricle')
    fs_icv = etree.SubElement(fs, 'freesurfer:icv')

    fs.set('xmlns:xnat', 'http://nrg.wustl.edu/xnat')
    fs.set('xmlns:prov', 'http://www.nbirn.net/prov')
    fs.set('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    fs.set('xmlns:freesurfer', 'http://nrg.wustl.edu/freesurfer')
    fsVersion.text = 'freesurfer-Linux-centos4_x86_64-stable-pub-v5.3.0'
    fs_gm_L_volCortex.text = str(gm_L_volCortex)
    fs_gm_R_volCortex.text = str(gm_R_volCortex)
    fs_gm_T_volCortex.text = str(gm_T_volCortex)
    fs_gm_L_volCerebellum.text = str(gm_L_volCerebellum)
    fs_gm_R_volCerebellum.text = str(gm_R_volCerebellum)
    fs_gm_T_volCerebellum.text = str(gm_T_volCerebellum)
    fs_gm_L_volNucleus.text = str(gm_L_volNucleus)
    fs_gm_R_volNucleus.text = str(gm_R_volNucleus)
    fs_gm_T_volNucleus.text = str(gm_T_volNucleus)
    fs_gm_L_volHemisphere.text = str(gm_L_volHemisphere)
    fs_gm_R_volHemisphere.text = str(gm_R_volHemisphere)
    fs_gm_T_volHemisphere.text = str(gm_T_volHemisphere)
    fs_gm_L_vol.text = str(gm_L_vol)
    fs_gm_R_vol.text = str(gm_R_vol)
    fs_gm_T_vol.text = str(gm_T_vol)
    fs_gm_L_hippo.text = str(gm_L_hippo)
    fs_gm_R_hippo.text = str(gm_R_hippo)
    fs_gm_T_hippo.text = str(gm_T_hippo)
    fs_gm_L_surface.text = str(gm_L_surface)
    fs_gm_R_surface.text = str(gm_R_surface)
    fs_gm_T_surface.text = str(gm_T_surface)
    fs_gm_L_ct.text = str(gm_L_ct)
    fs_gm_R_ct.text = str(gm_R_ct)
    fs_gm_T_ct.text = str(gm_T_ct)
    fs_wm_L_hemis.text = str(wm_L_hemis)
    fs_wm_R_hemis.text = str(wm_R_hemis)
    fs_wm_T_hemis.text = str(wm_T_hemis)
    fs_wm_L_volCerebellum.text = str(wm_L_volCerebellum)
    fs_wm_R_volCerebellum.text = str(wm_R_volCerebellum)
    fs_wm_T_volCerebellum.text = str(wm_T_volCerebellum)
    fs_wm_L_vol.text = str(wm_L_vol)
    fs_wm_R_vol.text = str(wm_R_vol)
    fs_wm_T_vol.text = str(wm_T_vol)
    fs_wm_cc.text = str(wm_cc)
    fs_csf_ventricle.text = str(csf_ventricle)
    fs_icv.text = str(icv)

    feo = etree.tostring(fs)
    reparsed = xml.dom.minidom.parseString(feo)
    reparsed.writexml(open(workdir + '/temp/fsStats.xml','w'), indent="\t", addindent="\t", newl="\n")
    
if __name__ == "__main__":
    main()
