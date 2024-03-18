#! /bin/bash

# fail on first error
set -e
EXPORTS_SET=0

if [ -z "$TERRAFORM_WORKSPACE_NAME" ] ; then
  echo Set TERRAFORM_WORKSPACE_NAME
  EXPORTS_SET=1
fi

if [ -z "$ENVIRONMENT" ] ; then
  echo Set ENVIRONMENT
  EXPORTS_SET=1
fi

if [ -z "$STACKS" ] ; then
  echo Set STACKS
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

export TF_VAR_repo_name="${REPOSITORY:-"$(basename -s .git "$(git config --get remote.origin.url)")"}"
# needed for terraform management stack
export TERRAFORM_BUCKET_NAME="nhse-$ENVIRONMENT-$TF_VAR_repo_name-terraform-state"  # globally unique name
export TERRAFORM_LOCK_TABLE="nhse-$ENVIRONMENT-$TF_VAR_repo_name-terraform-state-lock"

echo "Current terraform workspace is --> $TERRAFORM_WORKSPACE_NAME"
echo "Terraform state S3 bucket name is --> $TERRAFORM_BUCKET_NAME"
echo "Terraform state lock DynamoDB table is --> $TERRAFORM_LOCK_TABLE"
STACKS="$(echo $STACKS | sed s/\,/\ /g | sed s/\\\[/\ /g | sed s/\\\]/\ /g)"
echo "Stacks to be cleared down --> $STACKS"


# Delete terraform state for current terraform workspace & echo results following deletion

deletion_output=$(aws s3 rm s3://$TERRAFORM_BUCKET_NAME/env:/ --recursive --exclude "*" --include "$TERRAFORM_WORKSPACE_NAME/*" 2>&1)

if [ -n "$deletion_output" ]; then
    echo "Sucessfully deleted Terraform State file for the following workspace --> $TERRAFORM_WORKSPACE_NAME"

    # STACKS='stack1 stack2 stack3'
    for stack in $STACKS; do
        echo "$stack"  # remember quotes here
        existing_item=$(aws dynamodb get-item \
            --table-name "$TERRAFORM_LOCK_TABLE" \
            --key '{"LockID": {"S": "'${TERRAFORM_BUCKET_NAME}'/env:/'${TERRAFORM_WORKSPACE_NAME}'/'${stack}'/terraform.state-md5"}}' \
            2>&1)

        aws dynamodb delete-item \
            --table-name "$TERRAFORM_LOCK_TABLE" \
            --key '{"LockID": {"S": "'${TERRAFORM_BUCKET_NAME}'/env:/'${TERRAFORM_WORKSPACE_NAME}'/'${stack}'/terraform.state-md5"}}'

        after_deletion=$(aws dynamodb get-item \
            --table-name "$TERRAFORM_LOCK_TABLE" \
            --key '{"LockID": {"S": "'${TERRAFORM_BUCKET_NAME}'/env:/'${TERRAFORM_WORKSPACE_NAME}'/'${stack}'/terraform.state-md5"}}' \
            2>&1)
        if [[ -n "$existing_item" && -z "$after_deletion" ]]; then
            echo "Sucessfully deleted Terraform State Lock file for the following stack --> $stack"
        else
            echo "Terraform state Lock file not found for deletion or deletion failed for the following stack --> $stack"
            exit 1
        fi
    done
else
    echo "Terraform State file not found for deletion or deletion failed for the following workspace --> $TERRAFORM_WORKSPACE_NAME"
fi



