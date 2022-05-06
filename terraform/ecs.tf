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
