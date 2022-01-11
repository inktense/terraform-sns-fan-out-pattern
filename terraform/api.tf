resource "aws_api_gateway_rest_api" "fan_out_api_gateway" {
  name        = "${terraform.workspace}-fan-out-api-gateway"
  description = "Api Gateway implementation for SNS fan out pattern."
  body        = data.template_file.openapi_api_definition.rendered
}
resource "aws_api_gateway_resource" "resource" {
  path_part   = "resource"
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
  uri                     = aws_sns_topic.orders_topic.arn
}
