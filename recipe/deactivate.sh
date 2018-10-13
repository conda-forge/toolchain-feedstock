#!/bin/bash

if [ "$(uname)" == "Darwin" ];
then
    # for Mac OSX
    unset CC
    unset CXX
    unset FC
    unset F77
    unset F90
    unset F95
    unset MACOSX_VERSION_MIN
    unset MACOSX_DEPLOYMENT_TARGET
    unset CMAKE_OSX_DEPLOYMENT_TARGET
    unset CMAKE_OSX_SYSROOT
    unset SDKROOT
    unset CFLAGS
    unset CXXFLAGS
    unset LDFLAGS
    unset LINKFLAGS
elif [ "$(uname)" == "Linux" ]
then
    # for Linux
    unset CC
    unset CXX
    unset FC
    unset F77
    unset F90
    unset F95
    unset CFLAGS
    unset CXXFLAGS
    unset LDFLAGS
    unset LINKFLAGS
else
    echo "This system is unsupported by our toolchain."
    exit 1
fi
