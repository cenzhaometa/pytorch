#!/bin/bash

set -ex

# cuSPARSELt license: https://docs.nvidia.com/cuda/cusparselt/license.html
mkdir tmp_cusparselt && cd tmp_cusparselt

if [[ ${CUDA_VERSION:0:4} == "12.1" ]]; then
    CUSPARSELT_NAME="libcusparse_lt-linux-x86_64-0.5.2.1-archive"
    curl --retry 3 -OLs https://developer.download.nvidia.com/compute/cusparselt/redist/libcusparse_lt/linux-x86_64/${CUSPARSELT_NAME}.tar.xz
elif [[ ${CUDA_VERSION:0:4} == "11.8" ]]; then
    CUSPARSELT_NAME="libcusparse_lt-linux-x86_64-0.4.0.7-archive"
    curl --retry 3 -OLs https://developer.download.nvidia.com/compute/cusparselt/redist/libcusparse_lt/linux-x86_64/${CUSPARSELT_NAME}.tar.xz
fi

tar xf ${CUSPARSELT_NAME}.tar.xz
cp -a ${CUSPARSELT_NAME}/include/* /usr/local/cuda/include/
cp -a ${CUSPARSELT_NAME}/lib/* /usr/local/cuda/lib64/
cd ..
rm -rf tmp_cusparselt
ldconfig
