module "test_s3_bucket" {
  source      = "../../modules/s3"
  bucket_name = "nhse-uec-dos-mgm-test-ready-for-test-s3-bucket"
}
