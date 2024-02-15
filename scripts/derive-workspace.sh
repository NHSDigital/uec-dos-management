#! /bin/bash

TERRAFORM_WORKSPACE_NAME="default"

if [ -n "$WORKSPACE" ] ; then
    if  ! [[ $WORKSPACE =~ ^[RV]{1} ]]; then
      TERRAFORM_WORKSPACE_NAME=$(echo "$WORKSPACE" | tr "." "-")
    fi
else
  BRANCH_NAME="${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}"
  BRANCH_NAME=$(echo $BRANCH_NAME | sed 's/refs\/heads\/task/task/g')
  if [ "$BRANCH_NAME" != 'main' ] && [[ $BRANCH_NAME =~ $GIT_BRANCH_PATTERN ]]  ; then
    IFS='/' read -r -a name_array <<< "$BRANCH_NAME"
    IFS='_' read -r -a ref <<< "${name_array[1]}"
    TERRAFORM_WORKSPACE_NAME=$(echo "${ref[0]}" | tr "[:upper:]" "[:lower:]")
  fi
fi

export TERRAFORM_WORKSPACE_NAME
