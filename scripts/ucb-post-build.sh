#!/usr/bin/env bash

# TODO
echo "================================================================================"
echo "Environment"
echo "================================================================================"
set

echo "================================================================================"
echo "Parameters"
echo "================================================================================"
echo ${@}

usage() {
  echo "ucb-post-build.sh [?] [BUILD_PATH]"
  echo "  FIREBASE_TOKEN parameter must be set to the Firebase authorization token. See 'firebase login:ci'."
  echo "  FIREBASE_APP_ID parameter must be set to the Firebase App Id for this build"
  echo "  FIREBASE_GROUPS comma separated list of firebase groups to send build to"
  echo "  BUILD_FILE_NAME name of the build file e.g. 'wormhole.apk'"

  exit 1
}

if [ -z $FIREBASE_TOKEN ]
then
  echo "FIREBASE_TOKEN not set"
  usage
fi

if [ -z $FIREBASE_APP_ID ]
then
  echo "FIREBASE_APP_ID not set"
  usage
fi

if [ -z $FIREBASE_GROUPS ]
then
  echo "FIREBASE_GROUPS not set"
  usage
fi

if [ -z $BUILD_FILE_NAME ]
then
  echo "BUILD_FILE_NAME not set"
  usage
fi

BUILD_OUTPUT_PATH=${@:1}
BUILD_PATH=${@:2}
BUILD_TARGET=${@:3}

echo "Uploading to Firebase"
echo "FIREBASE_APP_ID=$FIREBASE_APP_ID"
echo "FIREBASE_GROUPS=$FIREBASE_GROUPS"
echo "BUILD_FILE_NAME=$BUILD_FILE_NAME"


cd $BUILD_PATH/.. ; echo $(PWD) ; npx firebase appdistribution:distribute --app "${FIREBASE_APP_ID}" --groups $FIREBASE_GROUPS ${BUILD_PATH}/${BUILD_FILE_NAME}