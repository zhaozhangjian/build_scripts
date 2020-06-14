#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/HIP/" ] || git clone https://github.com/ROCm-Developer-Tools/HIP.git ${ROCM_ROOT_DIR}/HIP

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/HIP/
git checkout rocm-3.1.x

mkdir -p build && cd build
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/umd_lib/lib/;
cmake -DCMAKE_BUILD_TYPE=Debug -DROCM_PATH=${ROCM_ROOT_DIR}/umd_lib \
    -DHSA_PATH=${ROCM_ROOT_DIR}/umd_lib/hsa -Damd_comgr_DIR=${ROCM_ROOT_DIR}/umd_lib/lib/cmake/amd_comgr \
    -DHCC_HOME=${ROCM_ROOT_DIR}/hcc/build -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
sudo make -j $(nproc) install
