#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi


[ -d "${ROCM_ROOT_DIR}/llvm/" ] || git clone --single-branch --recursive -b roc-hcc-2.9.x https://github.com/RadeonOpenCompute/llvm.git ${ROCM_ROOT_DIR}/llvm
[ -d "${ROCM_ROOT_DIR}/llvm/tools/clang" ] || git clone --single-branch --recursive -b roc-2.9.x https://github.com/RadeonOpenCompute/clang ${ROCM_ROOT_DIR}/llvm/tools/clang
[ -d "${ROCM_ROOT_DIR}/llvm/tools/lld" ] || git clone --single-branch --recursive -b roc-hcc-2.9.x https://github.com/RadeonOpenCompute/lld ${ROCM_ROOT_DIR}/llvm/tools/lld

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/llvm/
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib/llvm -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" ..
make -j 8
make install
