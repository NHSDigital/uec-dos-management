# /dos/aws_account_id_dev

data "aws_ssm_parameter" "aws_account_id_dev" {
  name = "/dos/aws_account_id_dev"
}

data "aws_ssm_parameter" "aws_account_id_test" {
  name = "/dos/aws_account_id_test"
}

data "aws_ssm_parameter" "aws_account_id_int" {
  name = "/dos/aws_account_id_int"
}

data "aws_ssm_parameter" "aws_account_id_preprod" {
  name = "/dos/aws_account_id_preprod"
}

data "aws_ssm_parameter" "aws_account_id_prod" {
  name = "/dos/aws_account_id_prod"
}
