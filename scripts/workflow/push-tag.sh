#! /bin/bash

# fail on first error
set -e
# This script pushes a git tag

# WORKSPACE is the workspace that we are generating the tag for. This really equates to the Jira task number
# TAG The tag to push

EXPORTS_SET=0

if [ -z "$TAG" ] ; then
    echo TAG not set
    EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more parameters not set
  exit 1
fi

echo "About to push tag: $TAG"

git tag "$TAG"
git push --tags
