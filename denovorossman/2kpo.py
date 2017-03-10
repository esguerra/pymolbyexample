#!/usr/bin/env python
################################################################################
# David van der Spoel
# spoel@xray.bmc.uu.se
# March 6, 2017
#
# This python script creates a .pml script which can be run
# using pymol to produce snapshots for a movie.
#
# This script can be invoked without
# X11 display with:
# pymol -qc scriptname.pml >& scriptname.log &
################################################################################
import os
mydir = "PNG"
if (not os.path.isdir(mydir)):
    os.mkdir(mydir)

size = 600
ray  = True

print ("load 2kpo.pdb")
print ("hide all")
print ("viewport %d,%d" % ( size, size ))
print ("select beta,res 2-7 or res 28-31 or res 52-58 or res 78-82")
print ("select alpha,res 11-26 or res 86-99 or res 61-73 or res 35-46")
print ("select loop,!alpha and !beta")
print ("color blue,beta")
print ("color red,alpha")
print ("color yellow,loop")
print ("select none")
print ("show cartoon,all")


angle = 0.5

count = 1000

# Rotate the molecule
for i in range(30):
    # Use ray tracing for better quality
    if ray:
        print ("ray %d,%d" % ( size, size ) )
    print ("rotate y,%g,all" % ( angle ) )
    print ("png %s/file%d.png" % ( mydir, count ) )
    count += 1

# Turn on the surface
print ("show surface,all")
for i in range(30):
    # Decrease transparency from almost complete to half
    trans = 1.0 - 0.01*(i+1)  
    print ("set transparency,%f" % ( trans) )
    if ray:
        print ("ray %d,%d" % ( size, size ) )
    print ("png %s/file%d.png" % (  mydir, count ) )
    count += 1

# Now rotate back    
for i in range(30):
    if ray:
        print ("ray %d,%d" % ( size, size ) )
    print ("rotate y,%g,all" % ( -angle ) )
    print ("png %s/file%d.png" % (  mydir, count) )
    count += 1

print("quit")
