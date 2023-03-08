# Selenium Node AV (Audio/Video)

This repo generates docker images for Selenium Grid nodes that have motre  

todo: all clips are 5s long in order to reduce images size

## Integration example

```python
todo
```

## Build locally

- Need:
  - ffmpeg
  - docker
- build:
  ```
  cd build && docker build \
  --file dockerfile-chrome  \
  --tag ghcr.io/avhb/node-chrome-av:$(cat node-chrome-upstream) \
  --build-arg UPSTREAM_VERSION=$(cat node-chrome-upstream) \
  .
  ```
- login to ghcr: `docker login ghcr.io -u {{username}} --password {{token}}`
- publish:       `docker push ghcr.io/avhb/node-chrome-av:$(cat node-chrome-upstream)`

## [INFO] Manually use the command line flags for fake audio streams

### Built-in fake webcam generator

Chrome (google-chrome, chromium and microsoft-edge) provides the option to pass a cli argument to generate a fake webcam and microphone feed to use as a test source without actually having to use a real cam, you can do this by using the following flag:
- `--use-fake-device-for-media-stream`: this enables the fake webcam device (a rotating circle), microphone sound will be simulated by a beep noise
- `--use-fake-ui-for-media-stream` (optional): this prevents the permission to use webcam popup

linux - tested on Ubuntu 22.04 (note: substitute `chromium` for `google-chrome` or `microsoft-edge` if needed):
```
chromium \
    --use-fake-device-for-media-stream \
    --use-fake-ui-for-media-stream \
    https://webrtc.github.io/test-pages/
```

### Custom fake webcam + audio

Once the video is at it's end, it will restart automatically

1. custom fake webcam
   - ".mjpeg" or ".y4m" file, y4m is difficult to generate (requires sed-command) and uncompressed, so it is very space-inefficient, just look at the difference
   - TODO add comparison picture here
   - ".y4m" still works as expected though
2. custom fake audio
   - ".wav" file

```
chromium \
    --use-fake-device-for-media-stream \
    --use-fake-ui-for-media-stream \
    --use-file-for-fake-video-capture=jelly.mjpeg \
    --use-file-for-fake-audio-capture=jelly.wav \
    https://webrtc.github.io/test-pages/
```

## [INFO] Generating mjpeg, y4m and wav files manually

### From a reference video

using this video as a source as it has audio as well: https://www.larmoire.info/jellyfish/media/jellyfish-55-mbps-hd-h264.mkv

1. mjpeg
   ```
   ffmpeg -i jellyfish-55-mbps-hd-h264.mkv jelly.mjpeg
   ```
2. y4m
   ```
   ffmpeg -i jellyfish-55-mbps-hd-h264.mkv -pix_fmt yuv420p jelly.y4m \
   && sed -i '0,/C420mpeg2/s//C420/' jelly.y4m
   ```
3. wav
   ```
   ffmpeg -i jellyfish-55-mbps-hd-h264.mkv -acodec pcm_s16le -ac 2 jelly.wav
   ```

### Using ffmpeg's built in generators

1. mjpeg testpattern
   ```
   ffmpeg -f lavfi -i testsrc -t 5 -pix_fmt yuv420p testpattern.mjpeg
   ```
2. wav sinewave (mono)
   ```
   ffmpeg -f lavfi -i "sine=frequency=1000:duration=5" sinewave-1000hz.wav
   ```
