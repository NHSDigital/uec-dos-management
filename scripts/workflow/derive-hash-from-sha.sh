#!/bin/bash
export SHA="${SHA:-""}"
export PULL_REQUEST="${PULL_REQUEST:-""}"

# check exports have been done
EXPORTS_SET=0
# Check key variables have been exported - see above
if [ -z "$SHA" ] ; then
  echo Set SHA to required sha for commit on required branch
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

commit_hash=$(git rev-parse --short "$SHA")
if [ -z "$PULL_REQUEST" ] ; then
    echo "setting commit_hash: $commit_hash"
    echo "commit_hash=$commit_hash" >> $GITHUB_OUTPUT
else
    echo "Setting artefact_commit_hash: $commit_hash"
    echo "artefact_commit_hash=$commit_hash" >> $GITHUB_OUTPUT
fi
