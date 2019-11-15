#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi


[ -d "${ROCM_ROOT_DIR}/ROCm-Device-Libs/" ] || git clone https://github.com/RadeonOpenCompute/ROCm-Device-Libs.git ${ROCM_ROOT_DIR}/ROCm-Device-Libs/

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/ROCm-Device-Libs/
git checkout roc-hcc-2.9.0
mkdir -p build && cd build
CC=${ROCM_ROOT_DIR}/umd_lib/llvm/bin/clang cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib/rocdl -DLLVM_DIR=${ROCM_ROOT_DIR}/umd_lib/llvm/ ..
make -j install
