#! /bin/bash

# fail on first error
set -e
EXPORTS_SET=0

# check necessary environment variables are set
if [ -z "$WORKSPACE" ] ; then
  echo Set WORKSPACE
  EXPORTS_SET=1
fi

if [ -z "$ENVIRONMENT" ] ; then
  echo Set ENVIRONMENT
  EXPORTS_SET=1
fi

if [ -z "$STACK" ] ; then
  echo Set STACK
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

# set additional environment variable
export TF_VAR_repo_name="${REPOSITORY:-"$(basename -s .git "$(git config --get remote.origin.url)")"}"
export TERRAFORM_BUCKET_NAME="nhse-$ENVIRONMENT-$TF_VAR_repo_name-terraform-state"  # globally unique name
export TERRAFORM_LOCK_TABLE="nhse-$ENVIRONMENT-$TF_VAR_repo_name-terraform-state-lock"

echo "Current terraform workspace is --> $WORKSPACE"
echo "Terraform state S3 bucket name is --> $TERRAFORM_BUCKET_NAME"
echo "Terraform state lock DynamoDB table is --> $TERRAFORM_LOCK_TABLE"

# Delete Terraform state and lock entries for each stack
echo "Stack to have terraform state deleted is: $STACK"

    # Delete terraform state for current terraform workspace & echo results following deletion
    deletion_output=$(aws s3 rm s3://$TERRAFORM_BUCKET_NAME/env:/$WORKSPACE/$STACK/terraform.state 2>&1)

    if [ -n "$deletion_output" ]; then
      echo "Sucessfully deleted Terraform State file for the following workspace --> $WORKSPACE"

      existing_item=$(aws dynamodb get-item \
          --table-name "$TERRAFORM_LOCK_TABLE" \
          --key '{"LockID": {"S": "'${TERRAFORM_BUCKET_NAME}'/env:/'${WORKSPACE}'/'${STACK}'/terraform.state-md5"}}' \
          2>&1)

      aws dynamodb delete-item \
          --table-name "$TERRAFORM_LOCK_TABLE" \
          --key '{"LockID": {"S": "'${TERRAFORM_BUCKET_NAME}'/env:/'${WORKSPACE}'/'${STACK}'/terraform.state-md5"}}' \

      after_deletion=$(aws dynamodb get-item \
          --table-name "$TERRAFORM_LOCK_TABLE" \
          --key '{"LockID": {"S": "'${TERRAFORM_BUCKET_NAME}'/env:/'${WORKSPACE}'/'${STACK}'/terraform.state-md5"}}' \
          2>&1)
      if [[ -n "$existing_item" && -z "$after_deletion" ]]; then
          echo "Sucessfully deleted Terraform State Lock file for the following stack --> $STACK"
      else
          echo "Terraform state Lock file not found for deletion or deletion failed for the following stack --> $STACK"
          exit 1
      fi
  else
    echo "Terraform State file not found for deletion or deletion failed for the following workspace --> $WORKSPACE"
  fi

