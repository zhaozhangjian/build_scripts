#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/rocm-cmake/
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
make install
