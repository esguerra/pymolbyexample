#!/bin/bash

#/Applications/Molviewers/macpymol1.4.app/Contents/MacOS/MacPyMOL schirle_macrae_2012.pml

for i in $(seq -w 1 1 60); do
    array+=("mov00$i.png ")
done
echo ${array[@]}

#cat `echo ${array[@]}` | ffmpeg -framerate 2/1 -i -  -c:v libx264 -r 30 -pix_fmt yuv420p  argonaute2.mp4
cat `echo ${array[@]}` | ffmpeg -framerate 2/1 -i -   -r 30 -pix_fmt yuv420p argonaute2.mp4


