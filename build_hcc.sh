#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/hcc/" ] || git clone --single-branch --recursive -b roc-2.6.x https://github.com/RadeonOpenCompute/hcc.git ${ROCM_ROOT_DIR}/hcc

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/hcc/
mkdir -p build && cd build
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/umd_lib/lib/; cmake -DCMAKE_BUILD_TYPE=Release -DHSA_LIBRARY="${ROCM_ROOT_DIR}/umd_lib/lib/libhsa-runtime64.so" -DHSA_HEADER="${ROCM_ROOT_DIR}/umd_lib/include" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib -DCPACK_PACKAGING_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
make -j $(nproc) install
