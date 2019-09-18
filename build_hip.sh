#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/HIP/" ] || git clone --single-branch --recursive -b roc-2.6.x https://github.com/ROCm-Developer-Tools/HIP.git ${ROCM_ROOT_DIR}/HIP

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/HIP/
mkdir -p build && cd build
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/umd_lib/lib/; cmake -DCOMPILE_HIP_ATP_MARKER=1 -DUSE_PROF_API=1 -DCMAKE_BUILD_TYPE=Debug -DHCC_HOME=${ROCM_ROOT_DIR}/hcc/build/ -DHSA_PATH=${ROCM_ROOT_DIR}/umd_lib/hsa -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib .. -DHIP_COMPILER=clang
make -j install
