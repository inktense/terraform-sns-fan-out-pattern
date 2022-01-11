#--------------------------------------------------------------
# Reporting Queue
#--------------------------------------------------------------
resource "aws_sqs_queue" "reporting_queue" {
  name                       = "${terraform.workspace}_reporting_queue"
  delay_seconds              = 0
  visibility_timeout_seconds = 600
}

resource "aws_sqs_queue_policy" "reporting_queue_policy" {
  queue_url = aws_sqs_queue.reporting_queue.id
  policy    = data.aws_iam_policy_document.reporting_queue_policy.json
}

data "aws_iam_policy_document" "reporting_queue_policy" {
  policy_id = "SQSReportingSendAccess"
  statement {
    sid     = "SQSReportingAccessStatement"
    effect  = "Allow"
    actions = ["SQS:SendMessage"]
    resources = [
      aws_sqs_queue.reporting_queue.arn
    ]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    condition {
      test     = "ArnEquals"
      values   = [aws_sns_topic.orders_topic.arn]
      variable = "aws:SourceArn"
    }
  }
}
#--------------------------------------------------------------
# Notifications Queue
#--------------------------------------------------------------
resource "aws_sqs_queue" "notification_queue" {
  name                       = "${terraform.workspace}_notification_queue"
  delay_seconds              = 0
  visibility_timeout_seconds = 600
}

resource "aws_sqs_queue_policy" "notification_queue_policy" {
  queue_url = aws_sqs_queue.notification_queue.id
  policy    = data.aws_iam_policy_document.notification_queue_policy.json
}

data "aws_iam_policy_document" "notification_queue_policy" {
  policy_id = "SQSNotificationSendAccess"
  statement {
    sid     = "SQSSNotificationAccessStatement"
    effect  = "Allow"
    actions = ["SQS:SendMessage"]
    resources = [
      aws_sqs_queue.notification_queue.arn
    ]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    condition {
      test     = "ArnEquals"
      values   = [aws_sns_topic.orders_topic.arn]
      variable = "aws:SourceArn"
    }
  }
}
#--------------------------------------------------------------
# Logistic Queue
#--------------------------------------------------------------
resource "aws_sqs_queue" "logistic_queue" {
  name                       = "${terraform.workspace}_logistic_queue"
  delay_seconds              = 0
  visibility_timeout_seconds = 600
}

resource "aws_sqs_queue_policy" "logistic_queue_policy" {
  queue_url = aws_sqs_queue.logistic_queue.id
  policy    = data.aws_iam_policy_document.logistic_queue_policy.json
}

data "aws_iam_policy_document" "logistic_queue_policy" {
  policy_id = "SQSLogistSendAccess"
  statement {
    sid     = "SQSLogistAccessStatement"
    effect  = "Allow"
    actions = ["SQS:SendMessage"]
    resources = [
      aws_sqs_queue.logistic_queue.arn
    ]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    condition {
      test     = "ArnEquals"
      values   = [aws_sns_topic.orders_topic.arn]
      variable = "aws:SourceArn"
    }
  }
}
