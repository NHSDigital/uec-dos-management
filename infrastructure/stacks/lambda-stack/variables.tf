variable "rest_api_name" {
  description = "Name of the api gateway"
}
variable "gateway_authorizer" {
  description = "Name of api gateway authoriser"
}
variable "logs_retention_days" {
  description = "Number of days to retain logs"
}

variable "healthcare_services_function_name" {
  description = "Name of lambda function for healthcare-services data manager"
}

variable "healthcare_services_dynamodb_table_name" {
  description = "Name of dynamodb table for healthcare services"
}

variable "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group"
}
