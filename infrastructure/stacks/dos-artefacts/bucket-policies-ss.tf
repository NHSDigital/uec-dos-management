# TODO remove dev access after testing
data "aws_iam_policy_document" "bucket_policy_ss_artefacts" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-management-github-runner",
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.ss_artefacts_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
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
      "${module.ss_artefacts_bucket.s3_bucket_arn}/*"
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
      "s3:PutObjectTagging"
    ]
    resources = [
      "${module.ss_artefacts_bucket.s3_bucket_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy_ss_artefacts_released" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.ss_artefacts_released_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
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
      "${module.ss_artefacts_released_bucket.s3_bucket_arn}/*",
    ]
  }
}
