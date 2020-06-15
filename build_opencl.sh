#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime/" ] || git clone   ssh://luozhongkui@10.63.20.3:29418/ROCm/ROCm-OpenCL-Runtime.git ${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime
[ -d "${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime/api/opencl/khronos/icd" ] || git clone  ssh://luozhongkui@10.63.20.3:29418/Khronos/OpenCL-ICD-Loader ${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime/api/opencl/khronos/icd


cd ROCm-OpenCL-Runtime
git checkout roc-3.3.x
cd api/opencl/khronos/icd
git checkout 978b4b3a29a3aebc86ce9315d5c5963e88722d03

cd ${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug  -DFIND_ROCR_LIBRARIES="${ROCM_ROOT_DIR}/ROCR-Runtime/src/build/libhsa-runtime64.so" -DFIND_ROCR_INCLUDES="${ROCM_ROOT_DIR}/ROCR-Runtime/src/inc" -DFIND_ROCT_LIBRARIES="${ROCM_ROOT_DIR}/ROCT-Thunk-Interface/build/libhsakmt.so" -DFIND_ROCT_INCLUDES="${ROCM_ROOT_DIR}/ROCT-Thunk-Interface/include" -DLLVM_INCLUDES=${ROCM_ROOT_DIR}/umd_lib/llvm/include -DCMAKE_PREFIX_PATH=${ROCM_ROOT_DIR}/ROCm-CompilerSupport/lib/comgr/build/lib/cmake/amd_comgr -DUSE_COMGR_LIBRARY=yes -DCMAKE_INSTALL_PREFIX=${ROCM_ROOT_DIR}/umd_lib  ..
make -j$(nproc) 
make install

