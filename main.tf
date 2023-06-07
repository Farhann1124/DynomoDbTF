provider "aws" {
  #access_key = var.aws_access_key
  #secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "aws_dynamodb_table" "my_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }
}
