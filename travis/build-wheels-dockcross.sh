#!/bin/bash
set -e -x

ORIG_PATH=$PATH
for pyver in 3.6 3.7; do

    export KALDI_ROOT=/opt/kaldi
    export WHEEL_FLAGS=`$CROSS_ROOT/bin/python${pyver}-config --cflags`
    export PATH=/opt/python/cp${pyver}-cp${pyver}m/bin:$ORIG_PATH
    echo $CROSS_TRIPLE
    case $CROSS_TRIPLE in
        *arm-*)
            export _PYTHON_HOST_PLATFORM=linux-armv6l
            ;;
        *armv7-*)
            export _PYTHON_HOST_PLATFORM=linux-armv7l
            ;;
        *aarch64-*)
            export _PYTHON_HOST_PLATFORM=linux-aarch64
            ;;
    esac

    pip3 wheel /io/python -w /io/wheelhouse

done
