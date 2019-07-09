#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/ROCm-CompilerSupport/lib/comgr
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH="${ROCM_ROOT_DIR}/hcc/build/lib/cmake" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
PATH=/data/rocm/umd_lib/bin:$PATH make -j $(nproc) install
