#!/bin/bash
source ./scripts/functions/git-functions.sh

exit_code=0
BUILD_COMMIT_MESSAGE=${BUILD_COMMIT_MESSAGE:-"$(cat $1)"}
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}

COMMIT_MESSAGE=$(check_jira_ref "$BRANCH_NAME" "$BUILD_COMMIT_MESSAGE")
sed -i -e "s/$BUILD_COMMIT_MESSAGE/$COMMIT_MESSAGE/g" $1
check_git_commit_message "$(cat $1)"
exit_code=$?

exit $exit_code
