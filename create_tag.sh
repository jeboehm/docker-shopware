#!/bin/sh

get_latest() {
    echo $(basename `find tags -mindepth 1 -type d | sort --version-sort | tail -n 1`)
}

TARGET_VERSION=${1}
LATEST_VERSION=$(get_latest)

if ! [ "${TARGET_VERSION}" ]
then
    echo "Target version missing"
    exit 1
fi

if [ -d "tags/${TARGET_VERSION}" ]
then
    echo "Version ${TARGET_VERSION} already exists."
    exit 1
fi

cp -a tags/${LATEST_VERSION} tags/${TARGET_VERSION}
sed -i.bak s:${LATEST_VERSION}:${TARGET_VERSION}:g docker-compose.yml tags/${TARGET_VERSION}/Dockerfile
