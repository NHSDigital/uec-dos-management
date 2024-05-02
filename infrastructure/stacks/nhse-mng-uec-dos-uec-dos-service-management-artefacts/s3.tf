module "sm_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.sm_artefacts_bucket_name
}

module "sm_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.sm_artefacts_released_bucket_name
}

module "ss_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ss_artefacts_bucket_name
}

module "ss_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ss_artefacts_released_bucket_name
}
module "cm_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.cm_artefacts_bucket_name
}

module "cm_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.cm_artefacts_released_bucket_name
}
module "um_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.um_artefacts_bucket_name
}

module "um_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.um_artefacts_released_bucket_name
}
module "ui_artefacts_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ui_artefacts_bucket_name
}

module "ui_artefacts_released_bucket" {
  source      = "../../modules/s3"
  bucket_name = var.ui_artefacts_released_bucket_name
}
