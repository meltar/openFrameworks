apt-get update

GSTREAMER_VERSION=0.10
GSTREAMER_FFMPEG=gstreamer${GSTREAMER_VERSION}-ffmpeg

echo "detectiing latest gstreamer version"
apt-cache show -n libgstreamer1.0-dev
exit_code=$?
if [ $exit_code != 0 ]; then
    echo selecting gstreamer 1.0
    GSTREAMER_VERSION=1.0
    GSTREAMER_FFMPEG=gstreamer${GSTREAMER_VERSION}-libav
fi


echo "installing OF dependencies"
apt-get install alsa-base alsa-tools alsa-utils libupnp-dev automake cvs libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libasound2-dev libxmu-dev libxxf86vm-dev g++ libgl1-mesa-dev libglu1-mesa-dev libraw1394-dev libudev-dev libdrm-dev libglew-dev libopenal-dev libsndfile-dev libfreeimage-dev libcairo2-dev libgtk2.0-dev python-lxml python-argparse libfreetype6-dev portaudio19-dev libssl-dev
exit_code=$?
if [ "$RET" -neq "0" ]; then
    echo "error installing dependencies, there could be an error with your internet connection"
    echo "if the error persists, please report an issue in github: http://github.com/openframeworks/openFrameworks/issues"
	exit $exit_code
fi


echo "installing gstreamer"
apt-get install libgstreamer${GSTREAMER_VERSION}-dev libgstreamer-plugins-base${GSTREAMER_VERSION}-dev  ${GSTREAMER_FFMPEG} gstreamer${GSTREAMER_VERSION}-pulseaudio gstreamer${GSTREAMER_VERSION}-x gstreamer${GSTREAMER_VERSION}-plugins-bad gstreamer${GSTREAMER_VERSION}-alsa gstreamer${GSTREAMER_VERSION}-plugins-base gstreamer${GSTREAMER_VERSION}-plugins-good
exit_code=$?
if [ $exit_code != 0 ]; then
	echo "error installing gstreamer, there could be an error with your internet connection"
    echo "if the error persists, please report an issue in github: http://github.com/openframeworks/openFrameworks/issues"
	exit $exit_code
fi

cd ..
./compileOF.sh
exit_code=$?
if [ $exit_code != 0 ]; then
  exit $exit_code
fi

./compilePG.sh
exit_code=$?
if [ $exit_code != 0 ]; then
  exit $exit_code
fi
