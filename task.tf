resource "aws_ecs_task_definition" "this" {
  family                   = var.name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.execution.arn
  task_role_arn            = aws_iam_role.task.arn

  cpu    = 1024
  memory = 2048

  container_definitions = jsonencode([{
    name      = var.name
    image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.name}-ui:latest"
    essential = true

    portMappings = [{
      protocol      = "tcp"
      containerPort = var.container_port
    }]

    logConfiguration = {
      logDriver = "awslogs"

      options = {
        awslogs-create-group  = "true"
        awslogs-group         = "/ecs/${var.name}"
        awslogs-stream-prefix = var.name
        awslogs-region        = var.aws_region
      }
    }
  }])
}
