provider "aws" {
  #access_key = var.aws_access_key
  #secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "aws_dynamodb_table" "my_table" {
  terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

resource "aws_dynamodb_table" "my_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "N"
  }
}

# Skip the aws_dynamodb_table_item resource here

# Run the AWS CLI commands to populate data
# This will be executed during the "terraform apply" step in GitHub Actions
resource "null_resource" "populate_data" {
  provisioner "local-exec" {
    command = <<EOT
aws dynamodb put-item \
  --region ${var.region} \
  --table-name ${aws_dynamodb_table.example_table.name} \
  --item '{"id": {"N": "1"}, "name": {"S": "John"}, "age": {"N": "30"}}'

aws dynamodb put-item \
  --region ${var.region} \
  --table-name ${aws_dynamodb_table.example_table.name} \
  --item '{"id": {"N": "2"}, "name": {"S": "Jane"}, "age": {"N": "25"}}'
EOT
  }
}

