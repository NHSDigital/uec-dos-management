/**************************
//
//HEALTHCARE SERVICES DATA MANAGER LAMBDA
//
**************************/
module "healthcare-services-data-manager-lambda" {
  source = "../../modules/lambda"

  function_name = var.healthcare_services_function_name
  description   = "Microservice for interacting with healthcare services dynamodb table"

  policy_jsons = [
    <<-EOT
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "DynamodbTable",
                    "Effect": "Allow",
                    "Action": [
                        "dynamodb:PutItem",
                        "dynamodb:DeleteItem",
                        "dynamodb:GetItem",
                        "dynamodb:Scan",
                        "dynamodb:Query",
                        "dynamodb:UpdateItem"
                    ],
                    "Resource": [
                        "${module.dynamodb_healthcare_services_table.dynamodb_table_arn}"
                    ]
                }
            ]
        }
        EOT
  ]
}
