# TODO remove dev access after testing
data "aws_iam_policy_document" "bucket_policy_cm_artefacts" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_4a903db5b9ddfab0",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_19e3f02bbd1bf46f",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_Admin_9a0e7f027698ab52"
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.cm_artefacts_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner"
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
      "${module.cm_artefacts_bucket.s3_bucket_arn}/*",
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
      "${module.cm_artefacts_bucket.s3_bucket_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy_cm_artefacts_released" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_4a903db5b9ddfab0",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-PowerUser_19e3f02bbd1bf46f",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_Admin_9a0e7f027698ab52"
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.cm_artefacts_released_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner"
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
      "${module.cm_artefacts_released_bucket.s3_bucket_arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy_cm_prototype_artefacts" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-prototype-github-runner"
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.cm_prototype_artefacts_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-prototype-github-runner"
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
      "${module.cm_prototype_artefacts_bucket.s3_bucket_arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy_cm_prototype_artefacts_released" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-prototype-github-runner"
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.cm_prototype_artefacts_released_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_CM-Developer_30f49a270d26af77",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prototype.value}:role/uec-cm-prototype-github-runner"
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
      "${module.cm_prototype_artefacts_released_bucket.s3_bucket_arn}/*",
    ]
  }
}
