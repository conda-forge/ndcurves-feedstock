#!/bin/sh

mkdir build
cd build

echo "TESTEST $PYTHON"

cmake ${CMAKE_ARGS} .. \
      --trace \
      --trace-expand \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DPYTHON_EXECUTABLE=$PYTHON \
      -DBUILD_DOCUMENTATION=OFF \
      -DBUILD_PYTHON_INTERFACE=OFF \
      -DGENERATE_PYTHON_STUBS=OFF \
      -DCURVES_WITH_PINOCCHIO_SUPPORT=ON \
      -DBUILD_TESTING=OFF

ninja
ninja install

if [[ $CONDA_BUILD_CROSS_COMPILATION == 1 ]]; then
  echo $BUILD_PREFIX
  echo $PREFIX
  sed -i.back 's|'"$BUILD_PREFIX"'|'"$PREFIX"'|g' $PREFIX/lib/cmake/ndcurves/ndcurvesTargets.cmake
  rm $PREFIX/lib/cmake/ndcurves/ndcurvesTargets.cmake.back
fi

