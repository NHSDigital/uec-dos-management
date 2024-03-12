#! /bin/bash
echo "Trigger: $TRIGGER"
echo "Trigger action: $TRIGGER_ACTION"
echo "Trigger reference: $TRIGGER_REFERENCE"
echo "Trigger head reference: $TRIGGER_HEAD_REFERENCE "

WORKSPACE="Unknown"

# If we are dealing with a tagging action, then the workspace is the name of the tag
if [ "$TRIGGER" == "tag" ] ; then
  WORKSPACE="$TRIGGER_REFERENCE"
  export WORKSPACE
  echo "Workspace from tag: $WORKSPACE"
else

  # If we are dealing with a push action or workflow_dispatch and the trigger is not a tag, we'll need to look at the branch name
  # to derive the workspace
  if [ "$TRIGGER_ACTION" == "push" ] || [ "$TRIGGER_ACTION" == "workflow_dispatch" ] ; then
    BRANCH_NAME="${BRANCH_NAME:-$(git rev-parse --abbrev-ref HEAD)}"
  # If trigger action is pull_request we will need to derive the workspace from the triggering head reference
  elif [ "$TRIGGER_ACTION" == "pull_request" ] ; then
    BRANCH_NAME="$TRIGGER_HEAD_REFERENCE"
  fi

  BRANCH_NAME=$(echo "$BRANCH_NAME" | sed 's/refs\/heads\/task/task/g')
  if [ "$BRANCH_NAME" == "main" ] ; then
    WORKSPACE="default"
    echo "Workspace from main: $WORKSPACE"
  else
    IFS='/' read -r -a name_array <<< "$BRANCH_NAME"
    IFS='_' read -r -a ref <<< "${name_array[1]}"
    WORKSPACE=$(echo "${ref[0]}" | tr "[:upper:]" "[:lower:]")
    echo "Workspace every: $WORKSPACE"
  fi

fi

# We will need some further logic here to derive the workspace upon branch deletion
# TBC
export WORKSPACE
