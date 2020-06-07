ROCM_ROOT_DIR=/data/rocm

if [ ! -z "$1" ]
then
    ROCM_ROOT_DIR="$1"
fi

./build_roct.sh "${ROCM_ROOT_DIR}"

if [ $? -eq 0 ]
then
  ./build_rocr.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0]
then
  ./build_llvm.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0]
then
  ./build_rocdl.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0 ]
then
  ./build_rocm-cmake.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0 ]
then
  ./build_comgr.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0 ]
then
  ./build_opencl.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0 ]
then
  ./build_rocclr.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0 ]
then
  ./build_hip.sh "${ROCM_ROOT_DIR}"
fi

if [ $? -eq 0 ]
then
  ./build_rocminfo.sh "${ROCM_ROOT_DIR}"
fi
