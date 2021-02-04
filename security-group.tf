resource "aws_security_group" "tf-allow-ssh" {
  name        = "tf-allow-ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.exec-vpc.id

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-allow-ssh"
  }
}

resource "aws_security_group" "tf-allow-http" {
  name        = "tf-allow-http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.exec-vpc.id

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.tf-alb-http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-allow-http"
  }
}

resource "aws_security_group" "tf-alb-http" {
  name        = "tf-alb-http"
  description = "Allow http inbound traffic alb"
  vpc_id      = aws_vpc.exec-vpc.id

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-alb-http"
  }
}