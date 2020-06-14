#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/ROCm-CompilerSupport/" ] || git clone https://github.com/RadeonOpenCompute/ROCm-CompilerSupport.git ${ROCM_ROOT_DIR}/ROCm-CompilerSupport

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/ROCm-CompilerSupport/
git checkout rocm-3.5.x

cd ./lib/comgr
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH="${ROCM_ROOT_DIR}/umd_lib/rocdl;${ROCM_ROOT_DIR}/umd_lib/llvm;${ROCM_ROOT_DIR}/umd_lib/share/rocm/cmake/" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
PATH=${ROCM_ROOT_DIR}/umd_lib/bin:$PATH make -j $(nproc) install
