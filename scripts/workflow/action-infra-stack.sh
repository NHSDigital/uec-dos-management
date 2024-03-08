#! /bin/bash
# You will need to export
# ACTION - The terraform action to perform, e.g. plan, apply, destroy, validate
# STACK - The infrastructure stack to action
# ENVIRONEMNT - The name of the environment to run the terraform action on, e.g. dev, test
# WORKSPACE - The name of the workspace to action the terraform into, e.g. DR-123
# REPOSITORY - The name of the repository to action the terraform on e.g. uec-dos-service-management

# fail on first error
set -e
# functions

export PROGRAM_CODE="${PROGRAM_CODE:-"nhse-uec"}"
export AWS_REGION="${AWS_REGION:-"eu-west-2"}"
export INFRASTRUCTURE_DIR="${INFRASTRUCTURE_DIR:-"infrastructure"}"
export TERRAFORM_DIR="${TERRAFORM_DIR:-"$INFRASTRUCTURE_DIR/stacks"}"
export ACTION="${ACTION:-""}"
export STACK="${STACK:-""}"
export ENVIRONMENT="${ENVIRONMENT:-""}"
export USE_REMOTE_STATE_STORE="${USE_REMOTE_STATE_STORE:-true}"
export ACCOUNT_PROJECT="${ACCOUNT_PROJECT:-"dos"}"
export TF_VAR_repo_name="${REPOSITORY:-"$(basename -s .git "$(git config --get remote.origin.url)")"}"

# needed for terraform management stack
export TF_VAR_terraform_state_bucket_name="nhse-$ENVIRONMENT-$TF_VAR_repo_name-terraform-state"  # globally unique name
export TF_VAR_terraform_lock_table_name="nhse-$ENVIRONMENT-$TF_VAR_repo_name-terraform-state-lock"

# needed only by github-runner stack
export TF_VAR_github_org="NHSDigital"
export HOST=$(curl https://token.actions.githubusercontent.com/.well-known/openid-configuration)
export CERT_URL=$(jq -r '.jwks_uri | split("/")[2]' <<< $HOST)
export THUMBPRINT=$(echo | openssl s_client -servername "$CERT_URL" -showcerts -connect "$CERT_URL":443 2> /dev/null | tac | sed -n '/-----END CERTIFICATE-----/,/-----BEGIN CERTIFICATE-----/p; /-----BEGIN CERTIFICATE-----/q' | tac | openssl x509 -sha1 -fingerprint -noout | sed 's/://g' | awk -F= '{print tolower($2)}')
# ------------- Step four create oidc identity provider, github runner role and policies for that role -----------
export TF_VAR_oidc_provider_url="https://token.actions.githubusercontent.com"
export TF_VAR_oidc_thumbprint=$THUMBPRINT
export TF_VAR_oidc_client="sts.amazonaws.com"

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

if [ -z "$TF_VAR_repo_name" ] ; then
  echo Set REPOSITORY to the REPOSITORY to action the terraform in
  EXPORTS_SET=1
fi

if [ $EXPORTS_SET = 1 ] ; then
  echo One or more exports not set
  exit 1
fi

function terraform-initialise {

    echo "Terraform S3 State Bucket Name: ${TF_VAR_terraform_state_bucket_name}"
    echo "Terraform Lock Table Name: ${TF_VAR_terraform_lock_table_name}"

    if [[ "$USE_REMOTE_STATE_STORE" =~ ^(false|no|n|off|0|FALSE|NO|N|OFF) ]]; then
      terraform init
    else
      terraform init \
          -backend-config="bucket=$TF_VAR_terraform_state_bucket_name" \
          -backend-config="dynamodb_table=$TF_VAR_terraform_lock_table_name" \
          -backend-config="encrypt=true" \
          -backend-config="key=$STACK/terraform.state" \
          -backend-config="region=$AWS_REGION"
    fi
}

COMMON_TF_VARS_FILE="common.tfvars"
STACK_TF_VARS_FILE="$STACK.tfvars"
PROJECT_TF_VARS_FILE="$ACCOUNT_PROJECT-project.tfvars"
ENV_TF_VARS_FILE="$ENVIRONMENT.tfvars"

echo "Preparing to run terraform $ACTION for stack $STACK to terraform workspace $WORKSPACE for environment $ENVIRONMENT and project $ACCOUNT_PROJECT"
ROOT_DIR=$PWD
# the directory that holds the stack to terraform
STACK_DIR=$PWD/$TERRAFORM_DIR/$STACK
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

# Select or create terraform workspace
terraform workspace select "$WORKSPACE" || terraform workspace new "$WORKSPACE"

# init terraform
terraform-initialise

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

