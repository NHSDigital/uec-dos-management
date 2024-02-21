#! /bin/bash
# You will need to export
# ACTION - The terraform action to perform, e.g. plan, apply, destroy, validate
# STACK - The infrastructure stack to action
# ENVIRONEMNT - The name of the environment to run the terraform action on, e.g. dev, test
# WORKSPACE - The name of the workspace to action the terraform into, e.g. DR-123

# fail on first error
set -e
# functions
source ./scripts/project-common.sh
source ./scripts/functions/terraform-functions.sh

export ACTION="${ACTION:-""}"
export STACK="${STACK:-""}"
export ENVIRONMENT="${ENVIRONMENT:-""}"
export USE_REMOTE_STATE_STORE="${USE_REMOTE_STATE_STORE:-true}"

# check exports have been done
EXPORTS_SET=0
# Check key variables have been exported - see above
if [ -z "$ACTION" ] ; then
  echo Set ACTION to terraform action one of plan, apply, destroy, or validate
  EXPORTS_SET=1
fi

if [ -z "$STACK" ] ; then
  echo Set STACK to name of the stack to be actioned
  EXPORTS_SET=1
fi

if [ -z "$ENVIRONMENT" ] ; then
  echo Set ENVIRONMENT to the environment to action the terraform in - one of dev, test, preprod, prod
  EXPORTS_SET=1
else
  if [[ ! $ENVIRONMENT =~ ^(mgmt|dev|test|preprod|prod|security) ]]; then
      echo ENVIRONMENT should be mgmt dev test preprod security or prod
      EXPORTS_SET=1
  fi
fi

if [ -z "$ACCOUNT_PROJECT" ] ; then
  echo Set ACCOUNT_PROJECT to dos or cm
  EXPORTS_SET=1
else
  if [[ ! "$ACCOUNT_PROJECT" =~ ^(dos|cm) ]]; then
      echo ACCOUNT_PROJECT should be dos or cm
      EXPORTS_SET=1
  fi
fi

if [ -z "$WORKSPACE" ] ; then
  echo Set WORKSPACE to the workspace to action the terraform in
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

# Only allow destroy on dev and test accounts for now
if [[ ! $ENVIRONEMNT =~ ^(mgmt|dev|test)  ]] && [ "$ACTION" = 'destroy' ] ; then
  echo Cannot run destroy action on this environment
  exit 1
fi

COMMON_TF_VARS_FILE="common.tfvars"
STACK_TF_VARS_FILE="$STACK.tfvars"
PROJECT_TF_VARS_FILE="$ACCOUNT_PROJECT-project.tfvars"
ENV_TF_VARS_FILE="$ENVIRONMENT.tfvars"

echo "Preparing to run terraform $ACTION for stack $STACK to terraform workspace $WORKSPACE for environment $ENVIRONMENT and project $ACCOUNT_PROJECT"
ROOT_DIR=$PWD
# the directory that holds the stack to terraform
STACK_DIR=$PWD/$INFRASTRUCTURE_DIR/stacks/$STACK
# remove any previous local backend for stack
rm -rf "$STACK_DIR"/.terraform
rm -f "$STACK_DIR"/.terraform.lock.hcl
cp "$ROOT_DIR"/"$INFRASTRUCTURE_DIR"/common/locals.tf "$STACK_DIR"
cp "$ROOT_DIR"/"$INFRASTRUCTURE_DIR"/common/provider.tf "$STACK_DIR"
cp "$ROOT_DIR"/"$INFRASTRUCTURE_DIR"/common/common-variables.tf "$STACK_DIR"
#  copy shared tf files to stack
if [[ "$USE_REMOTE_STATE_STORE" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON) ]]; then
  cp "$ROOT_DIR"/"$INFRASTRUCTURE_DIR"/remote/versions.tf "$STACK_DIR"
else
  cp "$ROOT_DIR"/"$INFRASTRUCTURE_DIR"/local/versions.tf "$STACK_DIR"
fi
# switch to target stack directory ahead of tf init/plan/apply
cd "$STACK_DIR" || exit
# if no stack tfvars create temporary one
TEMP_STACK_TF_VARS_FILE=0
if [ ! -f "$ROOT_DIR/$INFRASTRUCTURE_DIR/$STACK_TF_VARS_FILE" ] ; then
  touch "$ROOT_DIR/$INFRASTRUCTURE_DIR/$STACK_TF_VARS_FILE"
  TEMP_STACK_TF_VARS_FILE=1
fi

# init terraform
terraform-initialise "$STACK" "$ENVIRONMENT" "$USE_REMOTE_STATE_STORE"
#
terraform workspace select "$WORKSPACE" || terraform workspace new "$WORKSPACE"
#
# plan
if [ -n "$ACTION" ] && [ "$ACTION" = 'plan' ] ; then
  terraform plan \
  -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$COMMON_TF_VARS_FILE \
  -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$STACK_TF_VARS_FILE \
  -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$PROJECT_TF_VARS_FILE \
  -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$ENV_TF_VARS_FILE
fi

if [ -n "$ACTION" ] && [ "$ACTION" = 'apply' ] ; then
  terraform apply -auto-approve \
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$COMMON_TF_VARS_FILE \
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$STACK_TF_VARS_FILE \
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$PROJECT_TF_VARS_FILE \
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$ENV_TF_VARS_FILE
fi

if [ -n "$ACTION" ] && [ "$ACTION" = 'destroy' ] ; then
  terraform destroy -auto-approve\
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$COMMON_TF_VARS_FILE \
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$STACK_TF_VARS_FILE \
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$PROJECT_TF_VARS_FILE \
    -var-file $ROOT_DIR/$INFRASTRUCTURE_DIR/$ENV_TF_VARS_FILE
fi
if [ -n "$ACTION" ] && [ "$ACTION" = 'validate' ] ; then
  terraform validate
fi
# remove temp files
rm -f "$STACK_DIR"/locals.tf
rm -f "$STACK_DIR"/provider.tf
rm -f "$STACK_DIR"/versions.tf
rm -f "$STACK_DIR"/common-variables.tf

if [ $TEMP_STACK_TF_VARS_FILE = 1 ] ; then
  rm -f "$ROOT_DIR/$INFRASTRUCTURE_DIR/$STACK_TF_VARS_FILE"
fi

echo "Completed terraform $ACTION for stack $STACK to terraform workspace $WORKSPACE for account type $ENVIRONMENT  and project $ACCOUNT_PROJECT"

