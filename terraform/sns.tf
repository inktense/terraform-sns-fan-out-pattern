resource "aws_sns_topic" "orders_topic" {
  name = "${terraform.workspace}-ses-orders-topic"
}
