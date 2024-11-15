#!/bin/bash
source ./scripts/functions/git-functions.sh

# exit_code=0
echo $1
BUILD_COMMIT_MESSAGE=${BUILD_COMMIT_MESSAGE:-"$(cat $1)"}
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}

check_git_commit_message "$BUILD_COMMIT_MESSAGE" "$BRANCH_NAME"
# exit_code=$?

# TODO
# exit $exit_code
exit 1
