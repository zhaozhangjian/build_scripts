#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/ROCclr/" ] || git clone --single-branch --recursive -b roc-3.5.x https://github.com/RadeonOpenCompute/ROCclr.git ${ROCM_ROOT_DIR}/ROCclr

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/ROCclr/
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DOPENCL_DIR=${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime -DCMAKE_PREFIX_PATH="${ROCM_ROOT_DIR}/umd_lib;${ROCM_ROOT_DIR}/ROCT-Thunk-Interface/include" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib/vdi ..
make -j $(nproc)
make install
