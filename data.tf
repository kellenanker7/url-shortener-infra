data "aws_vpc" "this" {
  tags = {
    Name = var.aws_account_name
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.this.id

  filter {
    name   = "tag:Name"
    values = ["public-${var.aws_region}*"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.this.id

  filter {
    name   = "tag:Name"
    values = ["private-${var.aws_region}*"]
  }
}

data "aws_acm_certificate" "star_dot_kellenanker_dot_com" {
  domain   = "*.kellenanker.com"
  statuses = ["ISSUED"]
}
