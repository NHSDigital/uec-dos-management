#!/bin/bash

# fail on first error
set -e

export ARTEFACT_BUCKET_NAME="${ARTEFACT_BUCKET_NAME:-""}"
export WORKSPACE="${WORKSPACE:-""}"
export COMMIT_HASH="${COMMIT_HASH:-""}"

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

if [ -z "$ARTEFACT_BUCKET_NAME" ] ; then
  echo Set ARTEFACT BUCKET NAME to the artefact bucket name to action the terraform in
  EXPORTS_SET=1
fi

echo "Deploying to S3 bucket: $ARTEFACT_BUCKET_NAME"
echo "Workspace: $WORKSPACE"
echo "Commit Hash: $COMMIT_HASH"

# Deploy artefacts to s3 bucket
  aws s3 cp build/ s3://$ARTEFACT_BUCKET_NAME/$WORKSPACE/$COMMIT_HASH

  echo "Deployment completed"
fi
