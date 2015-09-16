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

__author__="nicolasvinuesa"
__date__ ="$Apr 24, 2014 11:12:27 AM$"

from xml.etree.ElementTree import Element
import xml.etree.ElementTree as etree
import xml.dom.minidom
import sys
import getopt

def main():
    try:
        o, a = getopt.getopt(sys.argv[1:], "hf:t:")
    except getopt.GetoptError as err:
        print err
        print 'removeTag.py -f <file> -t <tag number>'
        sys.exit(2)
    if len(o) < 2:
        print 'removeTag.py -f <file> -t <tag number>'
        sys.exit(2)
    for opt, arg in o:
        if opt == '-h':
            print 'removeTag.py -f <file> -t <tag number>'
            sys.exit()
        elif opt == '-f':
            file = arg
        elif opt == '-t':
            tagNumber = arg
            
    tree = etree.parse(file)
    root = tree.getroot()
    root.remove(root[int(tagNumber)]) # remove the second tag
    tree.write(file)

if __name__ == "__main__":
    main()
