#!/bin/bash

# fail on first error
set -e

export SERVICE="${SERVICE:-""}"
export TAG="${TAG:-""}"
export WORKSPACE="${WORKSPACE:-""}"

echo "Deploying service: ${SERVICE} version: ${TAG} into workspace: ${WORKSPACE}"

LAMBDA_FUNCTION="${SERVICE}"

if [ "${WORKSPACE}" != "default" ]; then
  LAMBDA_FUNCTION="${SERVICE}-${WORKSPACE}"
fi

echo "Deploying service into Lambda function: ${LAMBDA_FUNCTION}"

cd ./"${DIRECTORY}"/"${SERVICE}"

LAMBDA_OUTPUT=$(aws lambda update-function-code --function-name="${LAMBDA_FUNCTION}" --zip-file=fileb://deployment.zip --publish)
LATEST_VERSION=$(jq -r '.Version' --compact-output <<< "$LAMBDA_OUTPUT" )
PREVIOUS_VERSION=$(expr "${LATEST_VERSION}" - 1)
echo "Latest version: ${LATEST_VERSION}"
echo "Previous version: ${PREVIOUS_VERSION}"
