#!/bin/bash
# A script to create an ordered bash array to be sent via standard input
# to ffmpeg

for i in $(seq -w 2 1 32); do
    array+=("part00$i.png ")
done
for j in $(seq -w 2 1 32); do
	array+=("part10$j.png ")
done
for k in $(seq -w 2 1 32); do
	array+=("part100$k.png ")
done
for l in $(seq -w 2 1 32); do
	array+=("part110$l.png ")
done
for m in $(seq -w 2 1 32); do
	array+=("part1000$m.png ")
done
for ii in $(seq -w 2 1 32); do
	array+=("part1010$ii.png ")
done


# The following line shows the order in which the array will be passed to ffmpeg
# make sure that it's correct.
echo ${array[@]}

#cat `echo ${array[@]}` | ./ffmpeg-10bit -r 60 -f image2 -s 1920x1080 -i - -vcodec libx264 -crf 25 -vsync 2 -pix_fmt yuv420p test.mp4




