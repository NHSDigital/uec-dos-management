#! /bin/bash

# fail on first error
set -e
# This script generates a git tag
# The format for the tag is $WORKSPACE-$COMMIT_HASH_SHORT-$TAG_TYPE
# Where
# WORKSPACE is the workspace that we are generating the tag for. This really equates to the Jira task number
# TAG_TYPE is the type of tag to generate. Usually this equates to the environment that we want to deploy the tagged artifacts into; i.e. test, stage, prod

EXPORTS_SET=0

if [ -z "$WORKSPACE" ] ; then
    echo WORKSPACE not set
    EXPORTS_SET=1
fi

if [ -z "$TAG_TYPE" ] ; then
    echo TAG_TYPE not set
    EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more parameters not set
  exit 1
fi

COMMIT_HASH_SHORT="$(git rev-parse --short HEAD)"
TAG="$WORKSPACE-$COMMIT_HASH_SHORT-$TAG_TYPE"

echo "Generated tag: $TAG"

export TAG


