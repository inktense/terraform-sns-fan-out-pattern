#--------------------------------------------------------------
# API Gateway 
#--------------------------------------------------------------
resource "aws_iam_policy" "fan_out_policy" {
  name = "${terraform.workspace}-FanOutApiGatewayPolicy"

  policy = data.aws_iam_policy_document.sns_fan_out_inline_policy.json
}

resource "aws_iam_role" "fan_out_role" {
  name               = "${terraform.workspace}-FanOutApiGatewayRole"
  assume_role_policy = data.aws_iam_policy_document.api_gateway_role_trust.json
}

resource "aws_iam_role_policy_attachment" "fan_out_role_attachment" {
  role       = aws_iam_role.fan_out_role.name
  policy_arn = aws_iam_policy.fan_out_policy.arn
}

data "aws_iam_policy_document" "sns_fan_out_inline_policy" {
  statement {
    actions = [
      "sns:Publish",
    ]
    resources = [
      "${aws_sns_topic.orders_topic.arn}"
    ]
  }
}

data "aws_iam_policy_document" "api_gateway_role_trust" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}
