#!/bin/bash
ROCM_ROOT_DIR=/data/rocm-2.2
#cd ${ROCM_ROOT_DIR}/clBLAS/src
cd /data/rocm-2.5/clBLAS/src
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug .. -DOPENCL_LIBRARIES="${ROCM_ROOT_DIR}/opencl/build/lib/libOpenCL.so" -DOPENCL_INCLUDE_DIRS="${ROCM_ROOT_DIR}/opencl/api/opencl/khronos/headers/opencl2.2"
make -j 4
