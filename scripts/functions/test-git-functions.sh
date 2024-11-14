#!/bin/bash

#
#  scenario 1 dev has included jira ref in commit message - eg DR-9999 My commit message
#  - check it corresponds to branch name - what do we do if it doesnt
#  scenario 2 dev has NOT included jira ref in commit message - eg My commit message

#  branch name format is now DR_999_Branch_name_here NOT DR-999_Branch_name_here
#  If we are consistent (ie don't allow use of - or _) then deriving workspace is easier
#  and checking commit message and inserting jira ref if necessary is easier

# unset BRANCH_NAME
# unset BUILD_COMMIT_MESSAGE
BRANCH_NAME=${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}
BUILD_COMMIT_MESSAGE=${BUILD_COMMIT_MESSAGE:-"My standard commit message"}
echo "Testing branch name = $BRANCH_NAME"
echo "Testing commit message = $BUILD_COMMIT_MESSAGE"
# # Handle task branches with names delimited by underscore eg dr_9999_My_branch_name
# IFS='/' read -r -a name_array <<< "$BRANCH_NAME"
# IFS='_' read -r -a ref <<< "${name_array[1]}"
# JIRA_REF=$(echo "${ref[0]}"-"${ref[1]}")
# echo "JIRA_REF from branch: $JIRA_REF"

# # Check if commit message starts with jira ref
# if [[ $BUILD_COMMIT_MESSAGE == $JIRA_REF* ]] ; then
#   echo $BUILD_COMMIT_MESSAGE starts with $JIRA_REF - nothing to do
# else
#   echo $BUILD_COMMIT_MESSAGE does NOT start with $JIRA_REF - prepend jira ref
#   BUILD_COMMIT_MESSAGE="$JIRA_REF $BUILD_COMMIT_MESSAGE"
# fi

export BRANCH_NAME="$BRANCH_NAME"
export BUILD_COMMIT_MESSAGE="$BUILD_COMMIT_MESSAGE"
echo "Validating branch name = $BRANCH_NAME"
/bin/bash ./scripts/githooks/git-branch-commit-msg.sh
if [[ $? = 1 ]]; then
  echo "$BRANCH_NAME" is not valid
  all_pass=1
fi
echo "Validating commit message = $BUILD_COMMIT_MESSAGE"
/bin/bash ./scripts/githooks/git-commit-msg.sh
if [[ $? = 1 ]]; then
  echo "$BUILD_COMMIT_MESSAGE" is not valid
  all_pass=1
fi



# all_pass=0

# export BRANCH_NAME=task/DPTS_2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 1 ]]; then
#     all_pass=1
# fi

# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 1 ]]; then
#     all_pass=1
# fi
# export BRANCH_NAME=main
# export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 100 characters to describe the new commit here on this turbo tabletop"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 1 ]]; then
#     all_pass=1
# fi

# # invalid - jira project ref
# export BRANCH_NAME=task/D-22_My_invalid_branch
# export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 0 ]]; then
#   all_pass=1
# fi
# # invalid - jira project ref
# export BRANCH_NAME=task/DR2_My_invalid_branch
# export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # invalid - no initial cap
# export BRANCH_NAME=task/DR-2_my_invalid_branch
# export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # invalid - jira ref too long
# export BRANCH_NAME=task/DPTS-221111_My_invalid_br
# export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # invalid - branch name too long
# export BRANCH_NAME=task/DPTS-22111_My_invalid_branch_plus_more_and_text_here_o
# export BUILD_COMMIT_MESSAGE="DR-1 My valid commit message"
# /bin/bash ./scripts/githooks/git-branch-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi

# invalid comment - no jira ref
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="My invalid commit message"
# /bin/bash ./scripts/githooks/git-commit-msg.sh  "My valid commit message"
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # invalid comment - incomplete jira ref
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="D-1 Invalid commit message"
# /bin/bash ./scripts/githooks/git-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # invalid comment -jira ref has no hyphen
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR1 Invalid commit message"
# /bin/bash ./scripts/githooks/git-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # # invalid comment -jira ref too long
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR-111111 invalid commit message"
# /bin/bash ./scripts/githooks/git-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # # invalid comment -no initial cap
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR-11 invalid commit message"
# /bin/bash ./scripts/githooks/git-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # # invalid comment -no space after JIRA ref
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR-11My invalid commit message"
# /bin/bash ./scripts/githooks/git-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # # invalid comment - min three words
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR-11 My message"
# /bin/bash ./scripts/githooks/git-commit-msg.sh  "DR-11 My message"
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi
# # invalid comment - too long
# export BRANCH_NAME=task/DPTS-2211_My_valid_branch
# export BUILD_COMMIT_MESSAGE="DR-1 My message takes exactly 101 characters to describe the new commit here on this turbo tabletops"
# /bin/bash ./scripts/githooks/git-commit-msg.sh
# if [[ $? = 0 ]]; then
#     all_pass=1
# fi

if [[ $all_pass = 1 ]] ; then
  echo one or more tests failed
else
  echo all tests passed
fi

exit $all_pass
