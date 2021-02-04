resource "aws_lb" "application-lb" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf-alb-http.id]
  subnets            = [aws_subnet.tv-public-1.id, aws_subnet.tv-public-2.id, aws_subnet.tv-public-3.id ]

  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}


resource "aws_lb_target_group" "tg-terraform-alb" {
  name     = "tg-terraform-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.exec-vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-terraform-alb.arn
  }
}

resource "aws_lb_target_group_attachment" "vm-1" {
  target_group_arn = aws_lb_target_group.tg-terraform-alb.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "vm-2" {
  target_group_arn = aws_lb_target_group.tg-terraform-alb.arn
  target_id        = aws_instance.web2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "vm-3" {
  target_group_arn = aws_lb_target_group.tg-terraform-alb.arn
  target_id        = aws_instance.web3.id
  port             = 80
}