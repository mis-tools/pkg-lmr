#!/usr/bin/env bash
set -e
set -x
script_dir=$(dirname "$0")
cwd=`pwd`

itk_dir=$1

if [ -d $itk_dir ]; then
    source ${script_dir}/patch_itk.sh $itk_dir

    cd $itk_dir
    mkdir -p build
    cd build
    cmake .. \
	-DCMAKE_INSTALL_PREFIX=../install \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_C_COMPILER=/usr/bin/gcc \
	-DCMAKE_CXX_COMPILER=/usr/bin/g++ \
	-DBUILD_EXAMPLES:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
        -DITK_WRAP_PYTHON=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DITK_DYNAMIC_LOADING=OFF
    n=`nproc --ignore 1`
    make -j $n install
    cd $cwd
fi
