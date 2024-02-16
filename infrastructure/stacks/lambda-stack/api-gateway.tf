module "sm_rest_api" {
  source = "../../modules/api-gateway-rest-api"

  rest_api_name = var.rest_api_name
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = module.sm_rest_api.rest_api_id
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_api_gateway_method.healthcare_services_get,
    aws_api_gateway_method.healthcare_services_post,
    aws_api_gateway_method.healthcare_services_put,
    aws_api_gateway_method.healthcare_services_delete,
    module.healthcare_services_integrations_post,
    module.healthcare_services_integrations_put,
    module.healthcare_services_integrations_get,
    module.healthcare_services_integrations_delete,
  ]
  triggers = {
    redeployment = sha1(jsonencode([
      module.sm_rest_api
    ]))
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = module.sm_rest_api.rest_api_id
  stage_name    = "default"
}
