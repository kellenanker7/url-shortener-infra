resource "aws_ecr_repository" "ui" {
  name                 = "${var.name}-ui"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }
}
