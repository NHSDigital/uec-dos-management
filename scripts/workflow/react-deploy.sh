#!/bin/bash
export FRONT_END_DIR="${FRONT_END_DIR:-"src/backend"}"
export SPA_BUCKET_NAME="${SPA_BUCKET_NAME:-"src/backend"}"
# Navigate to the frontend directory if it exists
if [ -d "$FRONT_END_DIR" ]; then
  cd "$FRONT_END_DIR"  || exit
  echo "Deploying to $SPA_BUCKET_NAME"
  aws s3 sync build/ s3://$SPA_BUCKET_NAME/
else
  echo No frontend source code to deploy
fi
