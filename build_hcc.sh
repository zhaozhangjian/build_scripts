#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/hcc/" ] || git clone https://github.com/RadeonOpenCompute/hcc.git ${ROCM_ROOT_DIR}/hcc

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/hcc/
git checkout roc-3.1.x
git submodule update --recursive --init

mkdir -p build && cd build
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/umd_lib/lib/; cmake -DCMAKE_BUILD_TYPE=Release -DHSA_LIBRARY_DIR="${ROCM_ROOT_DIR}/umd_lib/lib/libhsa-runtime64.so" -DHSA_HEADER_DIR="${ROCM_ROOT_DIR}/umd_lib/include" -DROCM_INSTALL_PATH=${ROCM_ROOT_DIR}/umd_lib -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib -DCPACK_PACKAGING_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
sudo make -j $(nproc) install

# build llvm
#cd ${ROCM_ROOT_DIR}/hcc/llvm-project/
#mkdir -p build && cd build
#cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_ENABLE_PROJECTS="llvm;clang;lld" -DLLVM_TARGETS_TO_BUILD="AMDGPU;X86" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib/llvm ../llvm
#sudo make -j $(nproc) install

# build rocdl
#cd ${ROCM_ROOT_DIR}/hcc/rocdl/
#mkdir -p build && cd build
#CC=${ROCM_ROOT_DIR}/umd_lib/llvm/bin/clang cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib/rocdl -DLLVM_DIR=${ROCM_ROOT_DIR}/umd_lib/llvm/ ..
#sudo make -j $(nproc) install
