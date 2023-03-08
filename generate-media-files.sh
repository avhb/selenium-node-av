#!/bin/bash

# --no-clobber https://stackoverflow.com/a/4944353
wget --no-check-certificate --no-clobber https://www.larmoire.info/jellyfish/media/jellyfish-55-mbps-hd-h264.mkv

# -n https://superuser.com/a/922899
ffmpeg -n -i jellyfish-55-mbps-hd-h264.mkv jelly.mjpeg
ffmpeg -n -i jellyfish-55-mbps-hd-h264.mkv -acodec pcm_s16le -ac 2 jelly.wav
ffmpeg -n -f lavfi -i testsrc -t 5 -pix_fmt yuv420p testpattern.mjpeg
ffmpeg -n -f lavfi -i "sine=frequency=1000:duration=5" sinewave-1000hz.wav
ffmpeg -n -f lavfi -i flite=text='This is test audio' tts-thisistestaudio.wav
