# TODO remove dev access after testing
data "aws_iam_policy_document" "bucket_policy_ui_artefacts" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.dev_account_number}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${var.dev_account_number}:role/uec-dos-user-interfaces-github-runner",
        "arn:aws:iam::${var.test_account_number}:role/uec-dos-user-interfaces-github-runner",
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [

      "${module.ui_artefacts_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.dev_account_number}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${var.dev_account_number}:role/uec-dos-user-interfaces-github-runner",
        "arn:aws:iam::${var.test_account_number}:role/uec-dos-user-interfaces-github-runner",
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
      "${module.ui_artefacts_bucket.s3_bucket_arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "bucket_policy_ui_artefacts_released" {
  # github runner for all accounts developer for dev account only
  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.dev_account_number}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${var.dev_account_number}:role/uec-dos-user-interfaces-github-runner",
        "arn:aws:iam::${var.test_account_number}:role/uec-dos-user-interfaces-github-runner",
      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.ui_artefacts_released_bucket.s3_bucket_arn}"
    ]
  }

  statement {
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.dev_account_number}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${var.dev_account_number}:role/uec-dos-user-interfaces-github-runner",
        "arn:aws:iam::${var.test_account_number}:role/uec-dos-user-interfaces-github-runner",
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
      "${module.ui_artefacts_released_bucket.s3_bucket_arn}/*",
    ]
  }
}
