#!/usr/bin/python
################################################################################
# Mauricio Esguerra                     
# mauricio.esguerra@gmail.com
# Mar 9, 2017                           
#                                       
# A pymol example to create a camera approach movie.
#                                       
# This script can be invoked without    
# X11 display with:                     
# pymol -qc scriptname.pml >& scriptname.log &        
################################################################################


################################################################################
# Molecule Specific Commands
################################################################################
load 4ola.pdb
# Need to run 3dna to create the raster3d style CGO object for block display
# of nucleic acid bases:
#    blocview -o 4ola.pdb
#    mv blocview.r3d blocks.r3d
load blocks.r3d
hide everything
create protein, chain A
create nucleic, chain B and (not resn U)
remove 4ola in protein
remove 4ola in nucleic
disable 4ola
show cartoon, protein or nucleic
show cgo
show surface, protein
set surface_color, gray
set transparency, 0.5, protein
set cartoon_transparency, 0
set cartoon_ladder_mode, 0
set cartoon_rect_width, 1.2
set cartoon_rect_length, 0.9
set cartoon_cylindrical_helices, 1
set stick_radius, 0.14
show sticks, nucleic
zoom protein, 5

################################################################################
# General settings
################################################################################
set orthoscopic, 1


################################################################################
# Protein Secondary Structure Coloring
################################################################################
color blue, ss h
color red,  ss s
color grey, ss l+''
#color black, nucleic


################################################################################
# Movie Making
################################################################################
#unset movie_auto_interpolate
#set movie_loop, 0
unset movie_loop
scene first30, store


set cartoon_sampling, 6
zoom nucleic
hide surface
turn y, 180
set cartoon_transparency, 0.7
scene next30, store
# Nothing happens here between scene next30 and scene to60
scene to60, store


mset 1x60
mview store, 1, scene=first30
mview store, 30, scene=next30
mview store, 60, scene=to60

print cmd.count_frames()
print cmd.count_states()


#mplay
mstop

#Make images for movie
#viewport 1024,768
viewport 800, 800
set ray_trace_frames=0
set cache_frame=0
mpng mov


quit


