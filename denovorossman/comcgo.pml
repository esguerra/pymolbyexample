#!/usr/bin/env python
################################################################################
# Mauricio Esguerra
# mauricio.esguerra@gmail.com
# March 6, 2017
#
# Pymol Script for CGO display of an xyz axis centered on the center of mass.
#
# This script can be invoked without
# X11 display with:
# >pymol -qc scriptname.pml >& scriptoutput.log &
################################################################################
fetch 2kpo
orient (2kpo and chain A)
com1=cmd.get_position()
print cmd.get_position()
hide everything, 2kpo
show cartoon, 2kpo

# create the axes object, draw axes with cylinders coloured red, green,
#blue for X, Y and Z
python

# axes.py
from pymol.cgo import *
from pymol import cmd
from pymol.vfont import plain

# create the axes object, draw axes with cylinders coloured red, green,
#blue for X, Y and Z

obj = [
   CYLINDER, com1[0], com1[1], com1[2], com1[0]+10, com1[1]+10, com1[2], 0.3, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,
   CYLINDER, com1[0], com1[1], com1[2], com1[0]-10, com1[1]-10, com1[2], 0.3, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0,

   CYLINDER, com1[0], com1[1], com1[2], com1[0]-10, com1[1]+10, com1[2], 0.3, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0,
   CYLINDER, com1[0], com1[1], com1[2], com1[0]+10, com1[1]-10, com1[2], 0.3, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0,

   CYLINDER, com1[0], com1[1], com1[2], com1[0],    com1[1],    com1[2]+10, 0.3, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0,
   CYLINDER, com1[0], com1[1], com1[2], com1[0],    com1[1],    com1[2]-10, 0.3, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0,
   ]

cmd.load_cgo(obj,'axes')
python end

#png axisincom.png, width=1200, height=1200, dpi=600, ray=1

spectrum count, rainbow, all and name CA

deselect
