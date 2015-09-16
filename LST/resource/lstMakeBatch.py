#! /usr/bin/python

# Copyright (C) 2015 nicolasvinuesa
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
__date__ ="$Jul 21, 2015 10:19:35 AM$"

from xml.etree.ElementTree import Element
import xml.etree.ElementTree as etree
import xml.dom.minidom
import sys
import getopt

def main():
    try:
        o, a = getopt.getopt(sys.argv[1:], "hw:t:f:")
    except getopt.GetoptError as err:
        print err
        print 'lst_makeBatch.py -[w:t:f] args...'
        sys.exit(2)
    if len(o) < 2:
        print 'lst_makeBatch.py -[w:t:f] args...'
        sys.exit(2)
    for opt, arg in o:
        if opt == '-h':
            print 'mQcAssessor.py -[w:t:f] args...'
            sys.exit()
        elif opt == '-w':
            workdir = arg
        elif opt == '-t':
            pathT1 = arg
        elif opt == '-f':
            pathFLAIR = arg

    batchFile = workdir + '/batchLST.m'
    f = open(batchFile,"w") 

    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.data_T1 = {'" + pathT1 + "'};\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.data_FLAIR = {'" + pathFLAIR + "'};\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.initial = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1];\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.belief = 0;\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.mrf = 1;\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.maxiter = 50;\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.segopts.threshold = 0;\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.output.lesions.prob = 1;\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.output.lesions.binary = 0;\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.output.lesions.normalized = 0;\n")
    f.write("matlabbatch{1}.spm.tools.LST.lesiongrow.output.other = 1;\n")

    f.close()          

if __name__ == "__main__":
    main()
