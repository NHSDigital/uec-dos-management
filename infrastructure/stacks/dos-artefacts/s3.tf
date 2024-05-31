# Service management
module "sm_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.sm_artefacts_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_sm_artefacts" {
  depends_on = [module.sm_artefacts_bucket]
  bucket     = var.sm_artefacts_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_sm_artefacts.json
}

module "sm_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.sm_artefacts_released_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_sm_artefacts-released" {
  depends_on = [module.sm_artefacts_released_bucket]
  bucket     = var.sm_artefacts_released_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_sm_artefacts_released.json
}

# Service search
module "ss_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ss_artefacts_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_ss_artefacts" {
  depends_on = [module.ss_artefacts_bucket]
  bucket     = var.ss_artefacts_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_ss_artefacts.json
}

module "ss_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ss_artefacts_released_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_ss_artefacts-released" {
  depends_on = [module.ss_artefacts_released_bucket]
  bucket     = var.ss_artefacts_released_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_ss_artefacts_released.json
}

# Capacity management
module "cm_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.cm_artefacts_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_cm_artefacts" {
  depends_on = [module.cm_artefacts_bucket]
  bucket     = var.cm_artefacts_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_cm_artefacts.json
}

module "cm_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.cm_artefacts_released_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_cm_artefacts-released" {
  depends_on = [module.cm_artefacts_released_bucket]
  bucket     = var.cm_artefacts_released_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_cm_artefacts_released.json
}

# User management
module "um_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.um_artefacts_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_um_artefacts" {
  depends_on = [module.um_artefacts_bucket]
  bucket     = var.um_artefacts_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_um_artefacts.json
}

module "um_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.um_artefacts_released_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_um_artefacts-released" {
  depends_on = [module.um_artefacts_released_bucket]
  bucket     = var.um_artefacts_released_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_um_artefacts_released.json
}

#  User interfaces (DoS)
module "ui_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ui_artefacts_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_ui_artefacts" {
  depends_on = [module.ui_artefacts_bucket]
  bucket     = var.ui_artefacts_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_ui_artefacts.json
}

module "ui_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ui_artefacts_released_bucket_name
}
resource "aws_s3_bucket_policy" "bucket_policy_ui_artefacts-released" {
  depends_on = [module.ui_artefacts_released_bucket]
  bucket     = var.ui_artefacts_released_bucket_name
  policy     = data.aws_iam_policy_document.bucket_policy_ui_artefacts_released.json
}

# Management

module "management_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.management_artefacts_bucket_name
}

module "management_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.management_artefacts_released_bucket_name
}
