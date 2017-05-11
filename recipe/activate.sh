#!/bin/bash

if [ "$(uname)" == "Darwin" ]
then
    # for Mac OSX
    export CC=clang
    export CXX=clang++
    export MACOSX_VERSION_MIN="10.9"
    export MACOSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}"
    export CMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}"
    export CFLAGS="${CFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
    export CXXFLAGS="${CXXFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
    export LDFLAGS="${LDFLAGS} -headerpad_max_install_names"
    export LDFLAGS="${LDFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
    export LDFLAGS="${LDFLAGS} -lc++"
    export LINKFLAGS="${LDFLAGS}"
elif [ "$(uname)" == "Linux" ]
then
    # for Linux
    export CC=gcc
    export CXX=g++
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
    export LINKFLAGS="${LDFLAGS}"

    # 2 cores are available on CircleCI workers: https://discuss.circleci.com/t/what-runs-on-the-node-container-by-default/1443
    # MAKEFLAGS is passed through conda build: https://github.com/conda/conda-build/pull/917
    export MAKEFLAGS="-j2 ${MAKEFLAGS}"
else
    echo "This system is unsupported by the toolchain."
    exit 1
fi

export CFLAGS="${CFLAGS} -m${ARCH}"
export CXXFLAGS="${CXXFLAGS} -m${ARCH}"
