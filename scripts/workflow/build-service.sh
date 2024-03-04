#!/bin/bash

# fail on first error
set -e

export SERVICE="${SERVICE:-""}"
echo "Building service: ${SERVICE}"

echo "Copy utility code"
# copy util code but not the test code
rsync -av --exclude='test/' ./application-utils/* ./application/"${SERVICE}"

cd ./application/"${SERVICE}"

zip -r deployment.zip . -x "test*"

echo "Tidy up temporary files"
rm -rf ../../application/"${SERVICE}"/common/
