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
__date__ ="$Apr 23, 2014 10:10:55 AM$"

from xml.etree.ElementTree import Element
import xml.etree.ElementTree as etree
import xml.dom.minidom
import sys
import getopt

def main():
    try:
        o, a = getopt.getopt(sys.argv[1:], "hw:1:2:3:4:5:6:7:8:9:10:11:12:13:14:15:16:17:18:")
    except getopt.GetoptError as err:
        print err
        print 'mQcAssessor.py -[1:18] args...'
        sys.exit(2)
    if len(o) < 2:
        print 'mQcAssessor.py -[1:18] args...'
        sys.exit(2)
    for opt, arg in o:
        if opt == '-h':
            print 'mQcAssessor.py -[1:18] args...'
            sys.exit()
        elif opt == '-w':
            workdir = arg
        elif opt == '-1':
            com_T1 = arg
        elif opt == '-2':
            com_FLAIR = arg
        elif opt == '-3':
            com_T2 = arg
#        elif opt == '-4':
#            hye_T1 = arg
#        elif opt == '-5':
#            hyo_T1 = arg
#        elif opt == '-6':
#            com_T1 = arg
#        elif opt == '-7':
#            pos_FLAIR = arg
#        elif opt == '-8':
#            qua_FLAIR = arg
#        elif opt == '-9':
#            con_FLAIR = arg
#        elif opt == '-10':
#            hye_FLAIR = arg
#        elif opt == '-11':
#            hyo_FLAIR = arg
#        elif opt == '-12':
#            com_FLAIR = arg
#        elif opt == '-13':
#            pos_T2 = arg
#        elif opt == '-14':
#            qua_T2 = arg
#        elif opt == '-15':
#            con_T2 = arg
#        elif opt == '-16':
#            hye_T2 = arg
#        elif opt == '-17':
#            hyo_T2 = arg
#        elif opt == '-18':
#            com_T2 = arg
            


    manualqc = Element('manualqc:manualqcAssessorData')
#    mqc_Po_T1 = etree.SubElement(manualqc, 'manualqc:Position_T1')
#    mqc_Qu_T1 = etree.SubElement(manualqc, 'manualqc:Quality_T1')
#    mqc_Cn_T1 = etree.SubElement(manualqc, 'manualqc:Contrast_T1')
#    mqc_He_T1 = etree.SubElement(manualqc, 'manualqc:Hypersignaux_SB_T1')
#    mqc_Ho_T1 = etree.SubElement(manualqc, 'manualqc:Hyposignaux_SB_T1')
    mqc_Cm_T1 = etree.SubElement(manualqc, 'manualqc:Comments_T1')
#    mqc_Po_FLAIR = etree.SubElement(manualqc, 'manualqc:Position_FLAIR')
#    mqc_Qu_FLAIR = etree.SubElement(manualqc, 'manualqc:Quality_FLAIR')
#    mqc_Cn_FLAIR = etree.SubElement(manualqc, 'manualqc:Contrast_FLAIR')
#    mqc_He_FLAIR = etree.SubElement(manualqc, 'manualqc:Hypersignaux_SB_FLAIR')
#    mqc_Ho_FLAIR = etree.SubElement(manualqc, 'manualqc:Hyposignaux_SB_FLAIR')
    mqc_Cm_FLAIR = etree.SubElement(manualqc, 'manualqc:Comments_FLAIR')
#    mqc_Po_T2 = etree.SubElement(manualqc, 'manualqc:Position_T2')
#    mqc_Qu_T2 = etree.SubElement(manualqc, 'manualqc:Quality_T2')
#    mqc_Cn_T2 = etree.SubElement(manualqc, 'manualqc:Contrast_T2')
#    mqc_He_T2 = etree.SubElement(manualqc, 'manualqc:Hypersignaux_SB_T2')
#    mqc_Ho_T2 = etree.SubElement(manualqc, 'manualqc:Hyposignaux_SB_T2')
    mqc_Cm_T2 = etree.SubElement(manualqc, 'manualqc:Comments_T2')



    manualqc.set('xmlns:xnat', 'http://nrg.wustl.edu/xnat')
    manualqc.set('xmlns:prov', 'http://www.nbirn.net/prov')
    manualqc.set('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    manualqc.set('xmlns:manualqc', 'http://nrg.wustl.edu/manualqc')
    mqc_Cm_T1.text = com_T1
    mqc_Cm_FLAIR.text = com_FLAIR
    mqc_Cm_T2.text = com_T2

    feo = etree.tostring(manualqc)
    reparsed = xml.dom.minidom.parseString(feo)
    reparsed.writexml(open(workdir + '/mqc.xml','w'), indent="\t", addindent="\t", newl="\n")
    
#    print(min(map(int, pos_T1.split(','))))
if __name__ == "__main__":
    main()
