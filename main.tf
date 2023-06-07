terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_dynamodb_table" "example_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "N"
  }
}

# Run the AWS CLI commands to populate data
# This will be executed during the "terraform apply" step in GitHub Actions
resource "null_resource" "populate_data" {
  provisioner "local-exec" {
    command = <<EOT
aws dynamodb put-item \
  --region ${var.aws_region} \
  --table-name ${aws_dynamodb_table.example_table.name} \
  --item '{"id": {"N": "1"}, "name": {"S": "John"}, "age": {"N": "30"}}'

aws dynamodb put-item \
  --region ${var.aws_region} \
  --table-name ${aws_dynamodb_table.example_table.name} \
  --item '{"id": {"N": "2"}, "name": {"S": "Jane"}, "age": {"N": "25"}}'

aws dynamodb put-item \
  --region ${var.aws_region} \
  --table-name ${aws_dynamodb_table.example_table.name} \
  --item '{"id": {"N": "3"}, "name": {"S": "James"}, "age": {"N": "23"}}'
EOT
  }
}
