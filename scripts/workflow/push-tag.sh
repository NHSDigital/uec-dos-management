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

if [ -z "$TAG_OVERWRITE" ] ; then
    echo TAG_OVERWRITE not set
    EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more parameters not set
  exit 1
fi

echo "Checking to see if tag already exists: $TAG"
if [ $(git tag -l "$TAG") ]; then
    echo "Tag exists"
    if [ "$TAG_OVERWRITE" == "yes" ]; then
      git push --delete origin $TAG
    else
      echo "Exiting with error as we cannot overwrite an existing tag"
      exit 1
    fi
else
    echo "Tag does not exist"
fi

echo "About to push tag: $TAG"

git tag "$TAG"
git push --tags
