resource "aws_ecs_cluster" "example_ecspresso" {
  name = "example_ecspresso"
}

resource "aws_ecs_cluster_capacity_providers" "example_ecspresso" {
  cluster_name = aws_ecs_cluster.example_ecspresso.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "example_ecspresso" {
  family                   = "example_ecspresso_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name   = "example_ecspresso_task_1"
      image  = "${aws_ecrpublic_repository.example_ecspresso.repository_uri}:latest"
      cpu    = 256
      memory = 512
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "example_ecspresso" {
  name            = "example_ecspresso_service"
  cluster         = aws_ecs_cluster.example_ecspresso.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.example_ecspresso.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.example_ecspresso_1.id, aws_subnet.example_ecspresso_2.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.example_ecspresso.arn
    container_name   = "example_ecspresso_task_1"
    container_port   = 8080
  }
}
