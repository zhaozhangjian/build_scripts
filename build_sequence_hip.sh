./build_roct.sh

if [ $? -eq 0 ]
then
  ./build_rocr.sh
fi

if [ $? -eq 0 ]
then
  ./build_hcc.sh
fi

if [ $? -eq 0 ]
then
  ./build_comgr.sh
fi

if [ $? -eq 0 ]
then
  ./build_hip.sh
fi

if [ $? -eq 0 ]
then
  ./build_rocm-cmake.sh
fi

if [ $? -eq 0 ]
then
  ./build_rocminfo.sh
fi
