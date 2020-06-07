#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/HIP/" ] || git clone --single-branch --recursive -b roc-2.9.x https://github.com/ROCm-Developer-Tools/HIP.git ${ROCM_ROOT_DIR}/HIP

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/HIP/
mkdir -p build && cd build
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/umd_lib/lib/;
cmake -DUSE_PROF_API=1 -DCMAKE_BUILD_TYPE=Debug -DHIP_COMPILER=clang -DHIP_PLATFORM=rocclr \
    -DROCclr_DIR=${ROCM_ROOT_DIR}/ROCclr -DLIBROCclr_STATIC_DIR=${ROCM_ROOT_DIR}/ROCclr/build \
    -DHSA_PATH=${ROCM_ROOT_DIR}/umd_lib/hsa -DROCM_PATH=${ROCM_ROOT_DIR}/umd_lib \
    -Damd_comgr_DIR=${ROCM_ROOT_DIR}/umd_lib/lib/cmake/amd_comgr \
    -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
make -j $(nproc)
make install
