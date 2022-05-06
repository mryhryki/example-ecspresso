resource "aws_iam_role" "example_ecspresso" {
  name               = "example-ecspresso"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "example_ecspresso" {
  role       = aws_iam_role.example_ecspresso.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

