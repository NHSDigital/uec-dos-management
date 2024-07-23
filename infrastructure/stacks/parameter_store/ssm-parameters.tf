resource "aws_ssm_parameter" "dos_aws_account_id_dev" {
  name        = "/dos/aws_account_id_dev"
  description = "Id of current dev account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"
}

resource "aws_ssm_parameter" "dos_aws_account_id_test" {
  name        = "/dos/aws_account_id_test"
  description = "Id of current test account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"
}

resource "aws_ssm_parameter" "dos_aws_account_id_int" {
  name        = "/dos/aws_account_id_int"
  description = "Id of current integration test account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"
}

resource "aws_ssm_parameter" "dos_aws_account_id_preprod" {
  name        = "/dos/aws_account_id_preprod"
  description = ""
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"
}

resource "aws_ssm_parameter" "dos_aws_account_id_prod" {
  name        = "/dos/aws_account_id_prod"
  description = "Id of current preprod account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"
}

resource "aws_ssm_parameter" "dos_aws_account_id_prototype" {
  name        = "/dos/aws_account_id_prototype"
  description = "Id of the account used for prototype currently cm dev"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"
}
