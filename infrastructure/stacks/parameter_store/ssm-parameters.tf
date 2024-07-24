resource "aws_ssm_parameter" "dos_aws_account_id_dev" {
  name        = "/dos/aws_account_id_dev_testing"
  description = "Id of current dev account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "dos_aws_account_id_test" {
  name        = "/dos/aws_account_id_test_testing"
  description = "Id of current test account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "no longer default"
}

resource "aws_ssm_parameter" "dos_aws_account_id_int" {
  name        = "/dos/aws_account_id_int_testing"
  description = "Id of current integration test account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "dos_aws_account_id_preprod" {
  name        = "/dos/aws_account_id_preprod_testing"
  description = ""
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "dos_aws_account_id_prod" {
  name        = "/dos/aws_account_id_prod_testing"
  description = "Id of current preprod account"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "dos_aws_account_id_prototype" {
  name        = "/dos/aws_account_id_prototype_testing"
  description = "Id of the account used for prototype currently cm dev"
  type        = "SecureString"
  tier        = "Standard"
  value       = "default"

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
