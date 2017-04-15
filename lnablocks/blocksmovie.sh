#!/bin/bash
################################################################################
# Author: Mauricio Esguerra
# Date: April 14, 2017
# mauricio.esguerra@gmail.com
# 
# An example on how to create a movie using the output from a molecular
# dynamics trajectory file and the rigid-body representation of nucleotides
# using blocview from the x3dna suite of tools.
#
# Note that the coloring of the blocks is controlled in the par files in the
# config folder of 3DNA.
# The colors for chain are assigned according to the chain letter, in this
# example the chains were named X and Y. Changing the chain names to what one
# wants would take care of coloring.
# This can't be done easily in pymol since the p-atom tube trace is a cgo
# object just as the blocks are.
#
# Once the png images are created ffmpeg is used for stitching them together.
# Unfortunately the quality of the original png files is lost, for some unknown
# reason, the most noticeable effect is the loss of the fog effect.
################################################################################

#set -x
#trap read debug


case "$1" in
(clean)
################################################################################
# CLEAN: A clean function to remove all files created with the run function.
# 
################################################################################
rm -f *.r3d movie* frame* atom_lkg.alc bonds_lkg.dat temp2 bblk_lkg.alc \
   blocview.pdb serial_num.pdb tmp_file bislna.mp4 blocview.png msgfile \
   tb.pdb x3dna_r3d.avs blocksmovie.pml blocview_temp.pdb temp blocview \
   slurm*
exit 1
;;


(run)
################################################################################
# RUN: Define correct path to programs and call catdcd, blocview and pymol.
# blocview depends on ruby, raster3d and molscript.
################################################################################
module load gcc/6.2.0
module load ruby/2.3.4
#module load pymol/1.8.6.0
SOFT=/home/esguerra/software
BIN=/home/esguerra/bin
export PATH=$BIN/:$PATH

# 3DNA 2.3
export X3DNA='/home/apps/x3dna'
export PATH='/home/apps/x3dna/bin':$PATH
# molscript 2.1.2
export MOLSCRIPT=$SOFT/molscript-2.1.2/bin
export PATH=$MOLSCRIPT:$PATH
# raster3d 3
export RASTER3D=$SOFT/raster3d
export PATH=$RASTER3D:$PATH
# pymol 1.6
export PYMOL=/home/apps/pymol/1.6
export PATH=$PYMOL:$PATH
# libs
export LIBSOLD=/home/apps/OLD/lib64
export PATH=$LIBSOLD:$PATH

source /home/apps/OLD/bin/apps.sh

# Make block movie.
catdcd -o frame1.pdb -otype pdb -s notip3.pdb -first 1 -last 1 notip3_recenter.dcd
blocview -m -o frame1.pdb -r frame1.r3d
for i in `seq 50 50 8000`;
do
    echo $i
    catdcd -o frame$i.pdb -otype pdb -s notip3.pdb -first $i -last $i notip3_recenter.dcd
    blocview -m -o frame$i.pdb -r frame$i.r3d
done

echo "#!/bin/python
bg white
set orthoscopic, 1

load frame1.r3d, blockmov
for i in range(50,8000,50): cmd.load(\"frame%1d.r3d\"%i,\"blockmov\")
turn z, 90
turn y, 90
set light, [0,0,-0.2]
set ray_trace_mode, 1
set antialias, 5
set cgo_transparency, 0.3

#set ray_direct_shade, 0.2
#set ray_scatter, 0.4
#set hash_max, 220
#set depth_cue, 0
#set ray_shadows, 0

zoom
set opaque_background, 0
#viewport 800,600
#set ray_trace_frames, 1
#set cache_frames, 0
#mpng movie


python
for i in range(1,cmd.count_frames()+1):
  cmd.frame(i)
  print \"Frame => %s; and State => %s\" % ( str(i), str(cmd.get('state')))
  cmd.png(\"movie\" + str(\"%04d\" % i)  + \".png\", ray=1, width=1200, height=1200, dpi=600)
python end


" > blocksmovie.pml

pymol -qc blocksmovie.pml
#/Applications/Molviewers/macpymol1.4.app/Contents/MacOS/MacPyMOL -qc -k blocksmovie.pml

exit 0
;;

(*)
echo "Usage: $0 {clean|run}"
exit 2
;;

esac



