#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/HIP/
mkdir -p build && cd build
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/umd_lib/lib/; cmake -DCMAKE_BUILD_TYPE=Debug -DHCC_HOME=${ROCM_ROOT_DIR}/hcc/build/ -DHSA_PATH=${ROCM_ROOT_DIR}/umd_lib/hsa -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib ..
make -j 4
make install
