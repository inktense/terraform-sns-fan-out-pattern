resource "aws_api_gateway_rest_api" "fan_out_api_gateway" {
  name        = "${terraform.workspace}-fan-out-api-gateway"
  description = "Api Gateway implementation for SNS fan out pattern."
  body        = data.template_file.openapi_api_definition.rendered
}
resource "aws_api_gateway_resource" "resource" {
  path_part   = "oders"
  parent_id   = aws_api_gateway_rest_api.fan_out_api_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.fan_out_api_gateway.id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.fan_out_api_gateway.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.fan_out_api_gateway.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  credentials             = aws_iam_role.fan_out_role.arn
  uri                     = "arn:aws:apigateway:${var.aws_region}:sns:path//"

    request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
  }

    request_templates = {
    "application/json" = file("./mapping_template.json")
  }
}
