#!/bin/bash
ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

[ -d "${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime/" ] || git clone --single-branch --recursive -b roc-3.5.x https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git ${ROCM_ROOT_DIR}/ROCm-OpenCL-Runtime
