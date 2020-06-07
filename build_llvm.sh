#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi


[ -d "${ROCM_ROOT_DIR}/llvm-project/" ] || git clone --single-branch --recursive -b rocm-3.5.x git clone git@github.com:RadeonOpenCompute/llvm-project.git ${ROCM_ROOT_DIR}/llvm-project

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/llvm-project/
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_ENABLE_PROJECTS="llvm;clang;lld" -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib/llvm ../llvm
make -j 8
make install
