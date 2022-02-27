resource "aws_ecs_service" "this" {
  name        = var.name
  launch_type = "FARGATE"

  cluster         = aws_ecs_cluster.this.id
  task_definition = "${aws_ecs_task_definition.this.id}:${aws_ecs_task_definition.this.revision}"

  desired_count = length(data.aws_subnets.private.ids)

  deployment_maximum_percent         = 150
  deployment_minimum_healthy_percent = 0
  force_new_deployment               = true
  enable_execute_command             = false
  wait_for_steady_state              = true

  network_configuration {
    subnets          = data.aws_subnets.private.ids
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.name
    container_port   = var.container_port
  }

  propagate_tags = "SERVICE"

  depends_on = [aws_lb_listener.https]
}
