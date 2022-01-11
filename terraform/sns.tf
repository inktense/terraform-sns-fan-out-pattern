resource "aws_sns_topic" "orders_topic" {
  name = "${terraform.workspace}-ses-orders-topic"
}

resource "aws_sns_topic_subscription" "reporting_subscription" {
  topic_arn = aws_sns_topic.orders_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.reporting_queue.arn

  filter_policy = <<EOF
{
  "market": ["ru"]
}
EOF

}

resource "aws_sns_topic_subscription" "notications_subscription" {
  topic_arn = aws_sns_topic.orders_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notification_queue.arn
}

resource "aws_sns_topic_subscription" "logistic_subscription" {
  topic_arn = aws_sns_topic.orders_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.logistic_queue.arn
}

output "sns_mpd_labs_topic" {
  value = aws_sns_topic.orders_topic.id
}
