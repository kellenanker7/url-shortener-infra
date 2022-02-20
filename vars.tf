variable "aws_account_name" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

# ==========

variable "name" {
  type    = string
  default = "url-shortener"
}

variable "container_port" {
  type    = number
  default = 80
}
