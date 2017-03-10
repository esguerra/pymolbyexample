#!/usr/bin/python
################################################################################
# Benjamin Schroeder
# benjamin-schroeder@outlook.com
# Mar 9, 2017                           
#                                       
# A pymol example to create a movie using scenes to "store" display changes and
# frames for operations in space such as rotations.
#                                       
# This script can be invoked without    
# X11 display with:                     
# pymol -qc scriptname.pml >& scriptname.log &        
################################################################################
reinitialize
fetch 1VPR, async=0

mset 1x280	#define video with 280 frames

#////////////////////////////////////////////////////////////////////
#styling the view with  scenes:

hide all
show cartoon, all
color white, name N or name O or name C or name CA 
color purple,(res 921-931 or res 1036-1047) and elem C
scene 001, store
mview store, 1, scene=001

show sticks, res 930 and not (name C or name N or name O)
color orange, res 930 and elem C and not (name C or name CA)
scene 002, store
mview store, 120, scene=002
mview store, 280, scene=002

#////////////////////////////////////////////////////////////////////
#change the view:
# the set_view command for a certain view can easily be obtained by typing get_view in pymol

frame 1
set_view (\
     0.999826610,   -0.000886627,    0.018651593,\
     0.010490511,    0.852928817,   -0.521925092,\
    -0.015444950,    0.522032261,    0.852786422,\
    -0.000037417,    0.000467926, -178.675125122,\
    40.161735535,   67.906723022,   52.464115143,\
   129.288208008,  228.071868896,  -20.000000000 )
mview store
frame 80
set_view (\
     0.841132998,   -0.129050016,    0.525204480,\
     0.387181580,    0.821714103,   -0.418185323,\
    -0.377598464,    0.555103660,    0.741133511,\
    -0.000299200,    0.000565745, -178.675811768,\
    40.689537048,   69.830856323,   53.174869537,\
   129.288208008,  228.071868896,  -20.000000000 )
mview store

#do zooming here with the set_view
frame 120
set_view (\
     0.841132998,   -0.129050016,    0.525204480,\
     0.387181580,    0.821714103,   -0.418185323,\
    -0.377598464,    0.555103660,    0.741133511,\
    -0.000299200,    0.000565745, -178.675811768,\
    40.689537048,   69.830856323,   53.174869537,\
   129.288208008,  228.071868896,  -20.000000000 )
mview store

frame 160
set_view (\
     0.496734232,   -0.410605222,    0.764628947,\
     0.693801165,    0.717173159,   -0.065600038,\
    -0.521435320,    0.563085556,    0.641122162,\
     0.000000000,    0.000000000,  -24.429023743,\
    44.221199036,   65.867797852,   62.592201233,\
    -5.937198162,   54.795238495,  -20.000000000 )
mview store

frame 230
set_view (\
     0.119747140,   -0.346614420,    0.930332541,\
     0.574288845,    0.788572550,    0.219879359,\
    -0.809846997,    0.507949173,    0.293485761,\
     0.000000000,    0.000000000,  -24.429023743,\
    44.221199036,   65.867797852,   62.592201233,\
    -5.937198162,   54.795238495,  -20.000000000 )
mview store

frame 280
set_view (\
     0.119747140,   -0.346614420,    0.930332541,\
     0.574288845,    0.788572550,    0.219879359,\
    -0.809846997,    0.507949173,    0.293485761,\
     0.000000000,    0.000000000,  -24.429023743,\
    44.221199036,   65.867797852,   62.592201233,\
    -5.937198162,   54.795238495,  -20.000000000 )
mview store

mview reinterpolate
