#!/bin/bash
ROCM_ROOT_DIR=/data/rocm
cd ${ROCM_ROOT_DIR}/clBLAS/src
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug .. -DOPENCL_LIBRARIES="${ROCM_ROOT_DIR}/umd_lib/lib/libOpenCL.so" -DOPENCL_INCLUDE_DIRS="${ROCM_ROOT_DIR}/opencl/api/opencl/khronos/headers/opencl2.2" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib
make -j $(nproc) install
