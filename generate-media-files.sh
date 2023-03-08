#!/bin/bash

FOLDER_NAME=media

# cleanup
rm -rf ./build/$FOLDER_NAME
mkdir -p ./build/$FOLDER_NAME
cd ./build/$FOLDER_NAME

# download jellyfish video
wget --no-check-certificate -O /tmp/jellyfish.mkv https://www.larmoire.info/jellyfish/media/jellyfish-5-mbps-hd-h264.mkv

# -n https://superuser.com/a/922899
ffmpeg -n -ss 00:00:00 -t 15 -i /tmp/jellyfish.mkv jellyfish.mjpeg
ffmpeg -n -f lavfi -i testsrc -t 15 -pix_fmt yuv420p testsrc.mjpeg
ffmpeg -n -f lavfi -i smptebars -t 15 -pix_fmt yuv420p smptebars.mjpeg

ffmpeg -n -f lavfi -i "sine=frequency=100:duration=5" sinewave-100hz.wav
ffmpeg -n -f lavfi -i "sine=frequency=150:duration=5" sinewave-150hz.wav
ffmpeg -n -f lavfi -i "sine=frequency=500:duration=5" sinewave-500hz.wav
ffmpeg -n -f lavfi -i "sine=frequency=750:duration=5" sinewave-750hz.wav
ffmpeg -n -f lavfi -i "sine=frequency=1000:duration=5" sinewave-1000hz.wav
ffmpeg -n -f lavfi -i "sine=frequency=2600:duration=5" sinewave-2600hz.wav
ffmpeg -n -f lavfi -i "sine=frequency=5000:duration=5" sinewave-5500hz.wav
