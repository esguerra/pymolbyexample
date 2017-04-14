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
bg white
hide everything
create protein, chain A
create nucleic, chain B and (not resn U)
remove 4ola in protein
remove 4ola in nucleic
disable 4ola
show cartoon, protein or nucleic
set cartoon_sampling, 6
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
#zoom protein, 5

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
# Show slider
set movie_panel=1
set movie_panel_row_height, 30

#unset movie_auto_interpolate
#unset movie_loop
set movie_loop, 0

mset 1x60


# Go to frame 1
frame 1
zoom protein, 5
mview store

# betweem frame 1 and 28 turn and zoom
turn y, 180
show surface, protein
zoom nucleic
mview interpolate
frame 28
mview store


# from frame 18 to 60 stay static
# "and do the other things, not because they are easy..."
#turn y, 180
zoom nucleic
set cartoon_transparency, 0.7
hide surface, protein
frame 60
mview store
mview interpolate

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


