#!/bin/bash

dir=`pwd`

# set up the build directory
mkdir -p build
cd build

mkdir -p js
cd js

mkdir -p root
mkdir -p libvpx
cd libvpx

#

# finally, run configuration script
EMCONFIGURE_JS=1 \
  emconfigure ../../../libvpx/configure \
    --prefix="$dir/build/js/root" \
    --target=generic-gnu \
    --extra-cflags=-s\ WASM=0\ -DASMJS\ -I`dirname \`which emcc\``/system/lib/libcxxabi/include/ \
    --disable-multithread \
    --enable-vp9-decoder \
    --disable-vp8-encoder \
    --disable-vp9-encoder \
    --disable-shared \
    --disable-docs \
    --disable-examples \
    --disable-tools \
    --disable-unit-tests \
|| exit 1

# compile libvpx
emmake make -j4 || exit 1
emmake make install || exit 1

cd ..
cd ..
cd ..
