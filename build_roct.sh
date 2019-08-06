#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/ROCT-Thunk-Interface/" ] || git clone --single-branch --recursive -b roc-2.6.x https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface.git ${ROCM_ROOT_DIR}/ROCT-Thunk-Interface

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/ROCT-Thunk-Interface/
mkdir -p build && cd build
cmake ../ -DCMAKE_BUILD_TYPE="Debug" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib -DCPACK_PACKAGING_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib
make install
