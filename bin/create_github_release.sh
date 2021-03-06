#!/bin/bash

set -e

COMPOUND_VERSION=$1
TAG=$2
VIMR_FILE_NAME=$3
RELEASE_NOTES=$4
IS_SNAPSHOT=$5

pushd build/Release

tar cjf ${VIMR_FILE_NAME} VimR.app

PRERELEASE=""
if [ "${IS_SNAPSHOT}" = true ] ; then
    PRERELEASE="--pre-release"
fi

echo "### Creating release"
GITHUB_TOKEN=$(cat ~/.config/github.qvacua.release.token) github-release release \
    --user qvacua \
    --repo vimr \
    --tag "${TAG}" \
    --name "${COMPOUND_VERSION}" \
    --description "${RELEASE_NOTES}" \
    "${PRERELEASE}"

echo "### Uploading build"
GITHUB_TOKEN=$(cat ~/.config/github.qvacua.release.token) github-release upload \
    --user qvacua \
    --repo vimr \
    --tag "${TAG}" \
    --name "${VIMR_FILE_NAME}" \
    --file "${VIMR_FILE_NAME}"
