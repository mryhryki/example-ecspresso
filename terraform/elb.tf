resource "aws_lb" "example_ecspresso" {
  name               = "example-ecspresso"
  load_balancer_type = "application"
  subnets            = [aws_subnet.example_ecspresso_1.id, aws_subnet.example_ecspresso_2.id]
}

resource "aws_lb_target_group" "example_ecspresso" {
  name     = "example-ecspresso-group1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.example_ecspresso.id
}

resource "aws_lb_listener" "example_ecspresso" {
  load_balancer_arn = aws_lb.example_ecspresso.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_ecspresso.arn
  }
}
