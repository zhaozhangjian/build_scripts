#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/ROCR-Runtime/" ] || git clone https://github.com/RadeonOpenCompute/ROCR-Runtime.git ${ROCM_ROOT_DIR}/ROCR-Runtime

echo "Build output to $ROCM_ROOT_DIR/umd_lib"

cd ${ROCM_ROOT_DIR}/ROCR-Runtime/
git checkout rocm-3.1.x

cd src
mkdir -p build && cd build
cmake ../ -DCMAKE_BUILD_TYPE="Debug" -DHSAKMT_INC_PATH="${ROCM_ROOT_DIR}/ROCT-Thunk-Interface/include/" -DHSAKMT_LIB_PATH="${ROCM_ROOT_DIR}/umd_lib/lib/" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib
make -j $(nproc) install
