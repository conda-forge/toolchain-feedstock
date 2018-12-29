#!/bin/bash

if [ "$(uname)" == "Darwin" ]
then
    # for Mac OSX
    export AR=ar
    export CC=clang
    export CXX=clang++
    export FC=gfortran
    export F77=$FC
    export F90=$FC
    export F95=$FC
    export LD=ld
    export NM=nm
    export RANLIB=ranlib
    export STRIP=strip
    export MACOSX_VERSION_MIN="10.9"
    export MACOSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}"
    export CMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}"
    export CFLAGS="${CFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
    export CXXFLAGS="${CXXFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
    if [ ! -z "$CONDA_BUILD_SYSROOT" ]; then
        export CMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}"
        export SDKROOT="${CONDA_BUILD_SYSROOT}"
        export CFLAGS="${CFLAGS} -isysroot ${CONDA_BUILD_SYSROOT}"
        export CXXFLAGS="${CXXFLAGS} -isysroot ${CONDA_BUILD_SYSROOT}"
    fi
    export LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
    export LDFLAGS="${LDFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
    export LDFLAGS="${LDFLAGS} -lc++"
    export LDFLAGS="${LDFLAGS} -Wl,-rpath,$PREFIX/lib" 
    export LINKFLAGS="${LDFLAGS}"
elif [ "$(uname)" == "Linux" ]
then
    # for Linux
    export AR=ar
    export CC=gcc
    export CXX=g++
    export FC=gfortran
    export F77=$FC
    export F90=$FC
    export F95=$FC
    export LD=ld
    export NM=nm
    export RANLIB=ranlib
    export STRIP=strip
    export CFLAGS="${CFLAGS}"
    # Boost wants to enable `float128` support on Linux by default.
    # However, we don't install `libquadmath` so it will fail to find
    # the needed headers and fail to compile things. Adding this flag
    # tells Boost not to support `float128` and avoids this search
    # process. As it has confused a few people. We have added it here.
    # The idea to add this flag was inspired by this Boost ticked.
    #
    # https://svn.boost.org/trac/boost/ticket/9240
    #
    export CXXFLAGS="${CXXFLAGS} -DBOOST_MATH_DISABLE_FLOAT128"
    export LDFLAGS="${LDFLAGS}"
    export LDFLAGS="${LDFLAGS} -Wl,-rpath,$PREFIX/lib" 
    export LINKFLAGS="${LDFLAGS}"
else
    echo "This system is unsupported by the toolchain."
    exit 1
fi

export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
if [ ! -z "$ARCH" ]; then
    export CFLAGS="${CFLAGS} -m${ARCH}"
    export CXXFLAGS="${CXXFLAGS} -m${ARCH}"
fi
export CFLAGS="${CFLAGS} -fPIC"
export CXXFLAGS="${CXXFLAGS} -fPIC"
