#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/rocminfo/" ] || git clone --single-branch --recursive -b master https://github.com/RadeonOpenCompute/rocminfo ${ROCM_ROOT_DIR}/rocminfo

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/rocminfo/
git checkout master
mkdir -p build && cd build
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/ROCT-Thunk-Interface/build/; cmake -DROCM_DIR=${ROCM_ROOT_DIR}/umd_lib -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
sudo make install
