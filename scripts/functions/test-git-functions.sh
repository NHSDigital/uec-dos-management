#!/bin/bash
source ./scripts/functions/git-functions.sh

unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
# where commit message does NOT include jira ref it is added
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}
BUILD_COMMIT_MESSAGE=${BUILD_COMMIT_MESSAGE:-"My standard commit message"}
COMMIT_MESSAGE=$(check_jira_ref "$BRANCH_NAME" "$BUILD_COMMIT_MESSAGE")
if [[ "$COMMIT_MESSAGE" == "$BUILD_COMMIT_MESSAGE" ]]; then
  echo Commit message not changed to include jira ref
  all_pass=1
else
  echo "Orignal commit message $BUILD_COMMIT_MESSAGE changed to include jira ref -  $COMMIT_MESSAGE"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
# where commit message does include jira ref it is NOT added
BRANCH_NAME="task/DR_9999_No_such_branch"
BUILD_COMMIT_MESSAGE=${BUILD_COMMIT_MESSAGE:-"DR-9999 My standard commit message"}
COMMIT_MESSAGE=$(check_jira_ref "$BRANCH_NAME" "$BUILD_COMMIT_MESSAGE")
if [[ "$COMMIT_MESSAGE" != "$BUILD_COMMIT_MESSAGE" ]]; then
  echo "Original commit message $BUILD_COMMIT_MESSAGE changed to $COMMIT_MESSAGE"
  all_pass=1
else
  echo "Orignal commit message $BUILD_COMMIT_MESSAGE unchanged -  $COMMIT_MESSAGE"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE




all_pass=0
testcount=1

echo "start valid branch name checks"
export BRANCH_NAME=task/DPTS_2211_My_valid_branch
export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 1 ]]; then
    all_pass=1
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
export BRANCH_NAME=main
export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 1 ]]; then
    all_pass=1
fi

echo start invalid checks

unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
export BRANCH_NAME=hotfix/DPTS_2211_My_valid_branch
export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
echo "Test $testcount failed"
    all_pass=1
fi

unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
export BRANCH_NAME=feature/DPTS_2211_My_valid_branch
export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
echo "Test $testcount failed"
    all_pass=1
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid - jira project ref -hyphenated
export BRANCH_NAME=task/DPTS-2211_My_invalid_branch
export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid - jira project ref - single letter in ref
export BRANCH_NAME=task/D_22_My_invalid_branch
export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
  all_pass=1
  echo "Test $testcount failed"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid - jira project ref - no separator in ref
export BRANCH_NAME=task/DR2_My_invalid_branch
export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid - no initial cap
export BRANCH_NAME=task/DR_2_my_invalid_branch
export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid - jira ref too long
export BRANCH_NAME=task/DPTS_221111_My_invalid_br
export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid - branch name too long
export BRANCH_NAME=task/DPTS_22111_My_invalid_branch_plus_more_and_text_here_ove
export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
echo "end branch name checks"

echo "start invalid commit message checks"
# invalid comment - incomplete jira ref
export BUILD_COMMIT_MESSAGE="D-1 Invalid commit message"
check_git_commit_message "$BUILD_COMMIT_MESSAGE"
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid comment -jira ref has no hyphen
export BUILD_COMMIT_MESSAGE="DR1 Invalid commit message"
check_git_commit_message "$BUILD_COMMIT_MESSAGE"
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid comment -jira ref too long
export BUILD_COMMIT_MESSAGE="DR-111111 invalid commit message"
check_git_commit_message "$BUILD_COMMIT_MESSAGE"
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid comment -no initial cap
export BUILD_COMMIT_MESSAGE="DR-11 invalid commit message"
check_git_commit_message "$BUILD_COMMIT_MESSAGE"
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid comment - no space after JIRA ref
export BUILD_COMMIT_MESSAGE="DR-11My invalid commit message"
check_git_commit_message "$BUILD_COMMIT_MESSAGE"
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid comment - min three words
export BUILD_COMMIT_MESSAGE="DR-11 My message"
check_git_commit_message "$BUILD_COMMIT_MESSAGE"
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi
unset BUILD_COMMIT_MESSAGE
testcount=$((testcount+1))
# invalid comment - too long
export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 101 characters to describe the new commit here on this turbo tabletops"
check_git_commit_message "$BUILD_COMMIT_MESSAGE"
if [[ $? = 0 ]]; then
    all_pass=1
    echo "Test $testcount failed"
fi

unset BRANCH_NAME
unset BUILD_COMMIT_MESSAGE

if [[ $all_pass = 1 ]] ; then
  echo one or more tests failed
else
  echo all $testcount tests passed
fi

exit $all_pass
