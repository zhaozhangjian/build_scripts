#!/bin/bash
ROCM_ROOT_DIR=/data/rocm
ROCclr_DIR=${ROCM_ROOT_DIR}/ROCclr

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime/" ] || git clone --single-branch --recursive -b roc-3.5.x https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git ${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime

cd ROCm-OpenCL-Runtime
mkdir -p build; cd build
cmake -DROCclr_DIR=${ROCM_ROOT_DIR}/ROCclr -DUSE_COMGR_LIBRARY=yes -DLIBROCclr_STATIC_DIR=${ROCM_ROOT_DIR}/ROCclr/build  -DCMAKE_PREFIX_PATH=${ROCM_ROOT_DIR}/ROCm-CompilerSupport/lib/comgr/build/lib/cmake/amd_comgr -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
make -j$(nproc)
make install
