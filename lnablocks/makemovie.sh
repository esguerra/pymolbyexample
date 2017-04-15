
for i in $(seq -w 1 1 160); do
    array+=("movie0$i.png ")
done
echo ${array[@]}

rm bislna.mp4
#cat `echo ${array[@]}` | ffmpeg -framerate 1/1 -i -  -c:v libx264 -b 2000k -ab 192k  -vb 20M -r 30 -pix_fmt yuv420p  bislna.mp4
#cat `echo ${array[@]}` | ffmpeg -r 50 -i - -vcodec libx264 -pix_fmt yuv420p -vb 20M bislna.mp4
#cat `echo ${array[@]}` | ffmpeg  -i -  -framerate 1/20  -b:v 24000k  bislna.mp4
cat `echo ${array[@]}` | ffmpeg  -i - -r 50 -framerate 1/200 -preset slower -vf scale=1200:1200 -c:v mpeg2video -qscale:v 2 -b:v 24000k bislna.mp4
