#!/bin/bash
export ARTEFACT_BUCKET_NAME="${ARTEFACT_BUCKET_NAME:-""}"
export WORKSPACE="${WORKSPACE:-""}"
export COMMIT_HASH="${COMMIT_HASH:-""}"

echo "Deploying to S3 bucket: $ARTEFACT_BUCKET_NAME"
echo "Workspace: $WORKSPACE"
echo "Commit Hash: $COMMIT_HASH"

# Deploy artefacts to s3 bucket
  aws s3 sync build/ s3://$ARTEFACT_BUCKET_NAME/$WORKSPACE/$COMMIT_HASH

echo "Deployment completed"
fi
