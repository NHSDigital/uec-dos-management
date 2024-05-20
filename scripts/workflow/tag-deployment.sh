#!/bin/bash

# fail on first error
set -e

export COMMIT_HASH="${COMMIT_HASH:-""}"
export WORKSPACE="${WORKSPACE:-""}"
export ENVIRONMENT="${ENVIRONMENT:-""}"
export ARTEFACT_BUCKET_NAME="${ARTEFACT_BUCKET_NAME:-""}"
export DEPLOYMENT_FILE_NAME="${DEPLOYMENT_FILE_NAME:-""}"
# check exports have been done
EXPORTS_SET=0
# Check key variables have been exported - see above


if [ -z "$COMMIT_HASH" ] ; then
  echo Set COMMIT_HASH to identify which artefacts to be deployed
  EXPORTS_SET=1
fi

if [ -z "$WORKSPACE" ] ; then
  echo Set WORKSPACE to the workspace to action the terraform in
  EXPORTS_SET=1
fi

if [ -z "$ENVIRONMENT" ] ; then
  echo Set ENVIRONMENT to required environment eg dev, test, staging etc
  EXPORTS_SET=1
fi

if [ -z "$ARTEFACT_BUCKET_NAME" ] ; then
  echo Set ARTEFACT_BUCKET_NAME to name of s3 bucket holding artefacts for the repo
  EXPORTS_SET=1
fi

if [ -z "$DEPLOYMENT_FILE_NAME" ] ; then
  echo Set DEPLOYMENT_FILE_NAME to name of artefact to be tagged
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

echo "Tagging time of deployment of artefact ${ARTEFACT_BUCKET_NAME}/${WORKSPACE}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME} to ${ENVIRONMENT} "

DEPLOYED_AT=$(date '+%Y-%m-%d %H:%M:%S')
aws s3api put-object-tagging \
    --bucket "${ARTEFACT_BUCKET_NAME}"  \
    --key "${WORKSPACE}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}" \
    --tagging "{\"TagSet\": [{ \"Key\": \"${ENVIRONMENT}\", \"Value\": \"${DEPLOYED_AT}\" }]}"
