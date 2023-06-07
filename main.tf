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

resource "aws_dynamodb_table_item" "example_items" {
  table_name = aws_dynamodb_table.example_table.name

  item {
    id   = "1"
    name = "John"
    age  = 30
  }
  item {
    id   = "2"
    name = "Jane"
    age  = 25
  }
}
