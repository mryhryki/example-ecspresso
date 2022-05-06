resource "aws_lb" "example_ecspresso" {
  name               = "example-ecspresso"
  load_balancer_type = "application"
  subnets            = [aws_subnet.example_ecspresso_1.id, aws_subnet.example_ecspresso_2.id]
  security_groups    = [aws_security_group.example_ecspresso.id]
}

resource "aws_lb_target_group" "example_ecspresso" {
  name        = "example-ecspresso-group1"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.example_ecspresso.id

  health_check {
    port = 80
    path = "/"
  }
}

resource "aws_lb_listener" "example_ecspresso" {
  load_balancer_arn = aws_lb.example_ecspresso.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_ecspresso.arn
  }

  #  default_action {
  #    type             = "fixed-response"
  #
  #    fixed_response {
  #      content_type = "text/plain"
  #      status_code  = "200"
  #      message_body = "ok"
  #    }
  #  }
}

resource "aws_lb_listener_rule" "example_ecspresso" {
  listener_arn = aws_lb_listener.example_ecspresso.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_ecspresso.id
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}
