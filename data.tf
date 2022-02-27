data "aws_vpc" "this" {
  tags = {
    Name = var.aws_account_name
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Name"
    values = ["public-${var.aws_region}*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "tag:Name"
    values = ["private-${var.aws_region}*"]
  }
}

data "aws_acm_certificate" "star_dot_kellenanker_dot_com" {
  domain   = "*.kellenanker.com"
  statuses = ["ISSUED"]
}
