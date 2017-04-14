
for i in $(seq -w 1 1 80); do
    array+=("movie00$i.png ")
done
echo ${array[@]}

#cat `echo ${array[@]}` | ffmpeg -framerate 1/1 -i -  -c:v libx264 -b 2000k -ab 192k  -vb 20M -r 30 -pix_fmt yuv420p  bislna.mp4
#cat `echo ${array[@]}` | ffmpeg -r 50 -i - -vcodec libx264 -pix_fmt yuv420p -vb 20M bislna.mp4
cat `echo ${array[@]}` | ffmpeg -r 50 -i -  -pix_fmt yuv420p -vb 20M bislna.mp4
