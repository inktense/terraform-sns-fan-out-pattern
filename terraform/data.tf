# API definition is provided trough an openapi template.
# It includes responseTemplates and template mapping definitions.
data "template_file" "openapi_api_definition" {
  template = file("./openapi.yaml")

  vars = {
    fan_out_api_role = aws_iam_role.fan_out_role.arn
    oders_topic_uri  = "arn:aws:apigateway:${var.aws_region}:sns:path//"
    orders_topic     = aws_sns_topic.orders_topic.arn
  }

}
