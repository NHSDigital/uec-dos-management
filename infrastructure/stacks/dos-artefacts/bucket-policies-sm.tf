# TODO remove dev access after testing
data "aws_iam_policy_document" "bucket_policy_sm_artefacts" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_4a903db5b9ddfab0",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_Admin_d52b9f142fb98fdb",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_19e3f02bbd1bf46f",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_Admin_9a0e7f027698ab52"
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.sm_artefacts_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_4a903db5b9ddfab0",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_Admin_d52b9f142fb98fdb",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner"
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:PutObjectTagging"
    ]
    resources = [
      "${module.sm_artefacts_bucket.s3_bucket_arn}/*"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-management-github-runner",
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
    ]
    resources = [
      "${module.sm_artefacts_bucket.s3_bucket_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy_sm_artefacts_released" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_4a903db5b9ddfab0",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_Admin_d52b9f142fb98fdb",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_19e3f02bbd1bf46f",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_Admin_9a0e7f027698ab52"
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.sm_artefacts_released_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_DOS-PowerUser_4a903db5b9ddfab0",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_Admin_d52b9f142fb98fdb",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner",
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:PutObjectTagging"
    ]
    resources = [
      "${module.sm_artefacts_released_bucket.s3_bucket_arn}/*"
    ]
  }
}
