module "dynamodb_healthcare_services_table" {
  source = "../../modules/dynamodb"

  table_name = var.healthcare_services_dynamodb_table_name
}

