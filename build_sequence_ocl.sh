./build_roct.sh

if [ $? -eq 0 ]
then
  ./build_rocr.sh
fi

if [ $? -eq 0 ]
then
  ./build_opencl.sh
fi

if [ $? -eq 0 ]
then
  ./build_clBLAS.sh
fi
