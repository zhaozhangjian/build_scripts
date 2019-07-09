#!/bin/bash
ROCM_ROOT_DIR=/data/rocm
cd ${ROCM_ROOT_DIR}/opencl/
mkdir -p build && cd build
#ln -s ${ROCM_ROOT_DIR}/opencl/api/opencl/khronos/headers/opencl2.2/CL ${ROCM_ROOT_DIR}/opencl/api/opencl/khronos/icd/inc/CL
#cp ${ROCM_ROOT_DIR}/opencl/api/opencl/khronos/icd/loader/*.h ${ROCM_ROOT_DIR}/opencl/api/opencl/khronos/icd/
export LD_LIBRARY_PATH=${ROCM_ROOT_DIR}/umd_lib/lib/; cmake -DCMAKE_BUILD_TYPE=Debug .. -DROCR_LIBRARY="${ROCM_ROOT_DIR}/umd_lib/lib/libhsa-runtime64.so" -DROCR_INCLUDE_DIR="${ROCM_ROOT_DIR}/ROCR-Runtime/src/inc" -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib
make -j $(nproc) install
