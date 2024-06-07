# TODO remove dev access after testing
data "aws_iam_policy_document" "bucket_policy_ui_artefacts" {
  # github runner for all accounts developer for dev account only
  statement {
    sid = "AllDomainsAllAccountsListBucketUI"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        # cm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner",
        # sm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner",
        # ss
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-search-github-runner",
        # ui
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-interfaces-github-runner",
        # um
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-management-github-runner",


      ]
    }
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "${module.ui_artefacts_bucket.s3_bucket_arn}",
    ]
  }
  statement {
    sid = "NonUIDomainsAllAccounts"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        # cm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner",
        # sm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner",
        # ss
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-search-github-runner",
        # um
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-management-github-runner",

      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging"
    ]
    resources = [
      "${module.ui_artefacts_bucket.s3_bucket_arn}/*",
    ]
  }

  statement {
    sid = "UIDomainOnlyAllAccountsPreRelease"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-interfaces-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-interfaces-github-runner",
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
    sid = "AllDomainsAllAccountsListBucketUI"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        # cm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner",
        # sm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner",
        # ss
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-search-github-runner",
        # ui
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-interfaces-github-runner",
        # um
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-management-github-runner",
        #
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
    sid = "NonUIDomainsAllAccounts"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        # cm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-cm-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-cm-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-cm-github-runner",
        # sm
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-management-github-runner",
        # ss
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-service-search-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-service-search-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-service-search-github-runner",
        # um
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-management-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-management-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-management-github-runner",
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging"
    ]
    resources = [
      "${module.ui_artefacts_released_bucket.s3_bucket_arn}/*"
    ]
  }

  statement {
    sid = "UIDomainOnlyAllAccountsPostRelease"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/aws-reserved/sso.amazonaws.com/${var.aws_region}/AWSReservedSSO_DOS-Developer_8bdf3f98a2591a2b",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_dev.value}:role/uec-dos-user-interfaces-github-runner",
        "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_test.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_int.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_preprod.value}:role/uec-dos-user-interfaces-github-runner",
        # "arn:aws:iam::${data.aws_ssm_parameter.aws_account_id_prod.value}:role/uec-dos-user-interfaces-github-runner",
      ]
    }
    actions = [
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:PutObject",
      "s3:PutObjectTagging"
    ]
    resources = [
      "${module.ui_artefacts_released_bucket.s3_bucket_arn}/*"
    ]
  }
}
