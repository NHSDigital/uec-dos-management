#!/bin/bash

# fail on first error
set -e

export SERVICE="${SERVICE:-""}"
export COMMIT_HASH="${COMMIT_HASH:-""}"
export WORKSPACE="${WORKSPACE:-""}"
export CUSTOM_ARTEFACT_LOCATION="${CUSTOM_ARTEFACT_LOCATION:-""}"
export ENVIRONMENT="${ENVIRONMENT:-""}"
export APPLICATION_ROOT_DIR="${APPLICATION_ROOT_DIR:-"application"}"
export ARTEFACT_BUCKET_NAME="${ARTEFACT_BUCKET_NAME:-""}"

# TODO pass in artefact bucket name from PIRAs action
# check exports have been done
EXPORTS_SET=0
# Check key variables have been exported - see above
if [ -z "$SERVICE" ] ; then
  echo Set SERVICE to name of service aka function to be deployed
  EXPORTS_SET=1
fi

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

if [ -z "$APPLICATION_ROOT_DIR" ] ; then
  echo Set APPLICATION_ROOT_DIR to root directory of the service being deployed - eg application
  EXPORTS_SET=1
fi

if [ -z "$ARTEFACT_BUCKET_NAME" ] ; then
  echo Set ARTEFACT_BUCKET_NAME to name of s3 repo for domain artefacts
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

if [ "$ENVIRONMENT" == 'prod' ] ; then
  echo Copy artefacts to and deploy from released bucket
  aws s3 sync s3://"$ARTEFACT_BUCKET_NAME"  s3://"$ARTEFACT_BUCKET_NAME"-released --exclude "*" --include "$WORKSPACE/$COMMIT_HASH/*"
  export ARTEFACT_BUCKET_NAME="${ARTEFACT_BUCKET_NAME}-released"
fi

LAMBDA_FUNCTION="${SERVICE}"
export DEPLOYMENT_FILE_NAME="$SERVICE.zip"

if [ "${WORKSPACE}" != "default" ]; then
  LAMBDA_FUNCTION="${SERVICE}-${WORKSPACE}"
fi
echo "Pulling deployment artefact ${DEPLOYMENT_FILE_NAME} for service ${SERVICE}"

# TODO The if statements related to custom bucket locations shoud be refactored to be more elegant once we are happy this works

if [ -z "${CUSTOM_ARTEFACT_LOCATION}" ]; then
  echo "From ${ARTEFACT_BUCKET_NAME}/${WORKSPACE}/${COMMIT_HASH}"
else
  echo "From ${ARTEFACT_BUCKET_NAME}/${CUSTOM_ARTEFACT_LOCATION}/${COMMIT_HASH}"
  echo "Note that a custom artefact lookup location has been specified as ${CUSTOM_ARTEFACT_LOCATION} for this run."
fi

echo "For deployment to the lambda ${LAMBDA_FUNCTION} in the ${WORKSPACE} workspace in the ${ENVIRONMENT} environment"

# TODO can i pass file directly as zip-file parameter and avoid landing it in directory
cd ./"${APPLICATION_ROOT_DIR}"/"${SERVICE}"

if [ -z "${CUSTOM_ARTEFACT_LOCATION}" ]; then
  aws s3api get-object --bucket "${ARTEFACT_BUCKET_NAME}" --key "${WORKSPACE}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}" "${DEPLOYMENT_FILE_NAME}"
else
  aws s3api get-object --bucket "${ARTEFACT_BUCKET_NAME}" --key "${CUSTOM_ARTEFACT_LOCATION}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}" "${DEPLOYMENT_FILE_NAME}"
fi

LAMBDA_OUTPUT=$(aws lambda update-function-code --function-name="${LAMBDA_FUNCTION}" --zip-file=fileb://"${DEPLOYMENT_FILE_NAME}" --publish)
LATEST_VERSION=$(jq -r '.Version' --compact-output <<< "$LAMBDA_OUTPUT" )
PREVIOUS_VERSION=$(expr "${LATEST_VERSION}" - 1)

if [ -z "${CUSTOM_ARTEFACT_LOCATION}" ]; then
  echo "Artefact ${ARTEFACT_BUCKET_NAME}/${WORKSPACE}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}"
  echo "Deployed to version ${LATEST_VERSION} of the lambda ${LAMBDA_FUNCTION} in the ${WORKSPACE} in the ${ENVIRONMENT} environment"
  echo "Tagging time of deployment to ${ENVIRONMENT} of artefact ${ARTEFACT_BUCKET_NAME}/${WORKSPACE}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}"
else
echo "Artefact ${ARTEFACT_BUCKET_NAME}/${CUSTOM_ARTEFACT_LOCATION}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}"
echo "Deployed to version ${LATEST_VERSION} of the lambda ${LAMBDA_FUNCTION} in the ${CUSTOM_ARTEFACT_LOCATION} in the ${ENVIRONMENT} environment"
echo "Tagging time of deployment to ${ENVIRONMENT} of artefact ${ARTEFACT_BUCKET_NAME}/${CUSTOM_ARTEFACT_LOCATION}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}"
fi

echo "Replacing previous version: ${PREVIOUS_VERSION}"


DEPLOYED_AT=$(date '+%Y-%m-%d %H:%M:%S')
if [ -z "${CUSTOM_ARTEFACT_LOCATION}" ]; then
aws s3api put-object-tagging \
    --bucket "${ARTEFACT_BUCKET_NAME}"  \
    --key "${WORKSPACE}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}" \
    --tagging "{\"TagSet\": [{ \"Key\": \"${ENVIRONMENT}\", \"Value\": \"${DEPLOYED_AT}\" }]}"
else
    --bucket "${ARTEFACT_BUCKET_NAME}"  \
    --key "${CUSTOM_ARTEFACT_LOCATION}/${COMMIT_HASH}/${DEPLOYMENT_FILE_NAME}" \
    --tagging "{\"TagSet\": [{ \"Key\": \"${ENVIRONMENT}\", \"Value\": \"${DEPLOYED_AT}\" }]}"
fi
