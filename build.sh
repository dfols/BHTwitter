#!/bin/bash

LONG=sideloaded,rootless,trollstore
OPTS=$(getopt -a weather --longoptions "$LONG" -- "$@")
PROJECT_PATH=$PWD

while :; do
  case "$1" in
  --sideloaded)
    echo -e '\033[1m\033[32mBuilding BHTwitter project for Sideloaded.\033[0m'

    make clean
    rm -rf .theos
    make SIDELOADED=1

    if [ $? -eq 0 ]; then
      echo -e '\033[1m\033[32mMake command succeeded.\033[0m'
    else
      echo -e '\033[1m\033[31mMake command failed.\033[0m'
      exit 1
    fi

    # Package the built files
    mkdir -p packages/sideloaded
    cp .theos/obj/debug/*.dylib packages/sideloaded/
    cp -r layout/* packages/sideloaded/

    echo -e '\033[1m\033[32mSideloaded package is ready.\033[0m'
    break
    ;;
  --rootless)
    echo -e '\033[1m\033[32mBuilding BHTwitter project for Rootless.\033[0m'

    make clean
    rm -rf .theos
    export THEOS_PACKAGE_SCHEME=rootless
    make package

    if [ $? -eq 0 ]; then
      echo -e '\033[1m\033[32mRootless package built successfully.\033[0m'
    else
      echo -e '\033[1m\033[31mRootless package build failed.\033[0m'
      exit 1
    fi
    break
    ;;
  --trollstore)
    echo -e '\033[1m\033[32mBuilding BHTwitter project for TrollStore.\033[0m'

    make clean
    rm -rf .theos
    make TROLLSTORE=1

    if [ $? -eq 0 ]; then
      echo -e '\033[1m\033[32mMake command succeeded.\033[0m'
    else
      echo -e '\033[1m\033[31mMake command failed.\033[0m'
      exit 1
    fi

    # Package the built files
    mkdir -p packages/trollstore
    cp .theos/obj/debug/*.dylib packages/trollstore/
    cp -r layout/* packages/trollstore/

    echo -e '\033[1m\033[32mTrollStore package is ready.\033[0m'
    break
    ;;
  *)
    echo -e '\033[1m\033[32mBuilding BHTwitter project for Rootfull.\033[0m'

    make clean
    rm -rf .theos
    unset THEOS_PACKAGE_SCHEME
    make package

    if [ $? -eq 0 ]; then
      echo -e '\033[1m\033[32mRootfull package built successfully.\033[0m'
    else
      echo -e '\033[1m\033[31mRootfull package build failed.\033[0m'
      exit 1
    fi
    break
    ;;
  esac
done
