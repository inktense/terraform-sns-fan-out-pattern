resource "aws_api_gateway_rest_api" "fan_out_api_gateway" {
  name        = "${terraform.workspace}-fan-out-api-gateway"
  description = "Api Gateway implementation for SNS fan out pattern."
  body        = data.template_file.openapi_api_definition.rendered
}
