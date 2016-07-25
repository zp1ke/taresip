#!/bin/sh

function realpath 
{
     echo $(cd $(dirname "$1"); pwd)/$(basename "$1"); 
}

function download() 
{
    "${__DIR__}/download.sh" "$1" "$2"
}

function extract() 
{
    "${__DIR__}/extract.sh" "$1" "$2"
}

__FILE__=`realpath "$0"`
__DIR__=`dirname "${__FILE__}"`
BUILD_DIR="${__DIR__}/build"

# library
function library() 
{
    LIB_PATH="${BUILD_DIR}/${1}"
    
    download ${2} "${LIB_PATH}.tar.gz"

    extract "${LIB_PATH}.tar.gz" ${BUILD_DIR}
    
    rm -rf "${LIB_PATH}.tar.gz"
    mv "${BUILD_DIR}/${1}" "${BUILD_DIR}/${3}"
}

# baresip-ios
function baresipIOS()
{
    BS_NAME="baresip-ios"
    
    cp -R "${__DIR__}/cross" "${BUILD_DIR}/${BS_NAME}"
    mv "${BUILD_DIR}/${1}" "${BUILD_DIR}/${BS_NAME}/${1}"
    mv "${BUILD_DIR}/${2}" "${BUILD_DIR}/${BS_NAME}/${2}"
    mv "${BUILD_DIR}/${3}" "${BUILD_DIR}/${BS_NAME}/${3}"
    
    cd "${BUILD_DIR}/${BS_NAME}"
    make contrib

    mkdir "${BUILD_DIR}/${1}"
    mkdir "${BUILD_DIR}/${2}"
    mkdir "${BUILD_DIR}/${3}"

    mv "${BUILD_DIR}/${BS_NAME}/contrib/fat/lib" "${BUILD_DIR}/lib"
    mv "${BUILD_DIR}/${BS_NAME}/${1}/include" "${BUILD_DIR}/${1}"
    mv "${BUILD_DIR}/${BS_NAME}/${2}/include" "${BUILD_DIR}/${2}"
    mv "${BUILD_DIR}/${BS_NAME}/${3}/include" "${BUILD_DIR}/${3}"

    rm -rf "${BUILD_DIR}/${BS_NAME}"
}

rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}

DOWNLOAD_URL="http://www.creytiv.com/pub"
library "re-0.4.17" "${DOWNLOAD_URL}/re-0.4.17.tar.gz" "re"
library "rem-0.4.7" "${DOWNLOAD_URL}/rem-0.4.7.tar.gz" "rem"
library "baresip-0.4.20" "${DOWNLOAD_URL}/baresip-0.4.20" "baresip"

baresipIOS "re" "rem" "baresip"
