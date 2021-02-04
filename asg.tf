resource "aws_launch_configuration" "exec-template" {
  name_prefix = "exec-template"

  image_id                = "ami-0c20b8b385217763f"
  instance_type           = var.AWS_INSTANCE_TYPE
  key_name                = aws_key_pair.exec-key.key_name

  security_groups = [ aws_security_group.tf-allow-http.id ]
  associate_public_ip_address = true
  user_data               = <<-EOF
                      #! /bin/bash
                      sudo apt update
                      sudo apt install apache2 -y
                      sudo systemctl start apache2
                      sudo systemctl enable apache2
                      sudo rm -rf /var/www/html/*
                      echo "================================= CLONE TEMPLATE FROM GITHUB ============================="
                      sudo git clone https://github.com/hisbu/template2.git /var/www/html/
                      echo "================================= add hostname ============================="
                      sudo sed -i -e '1 i\<center>'$(hostname -f)'</center>' /var/www/html/index.html
                    EOF 

  

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.exec-asg.id
  alb_target_group_arn   = aws_lb_target_group.tg-terraform-alb.arn
}

resource "aws_autoscaling_group" "exec-asg" {
  name = "exec-asg"

  min_size             = 3
  desired_capacity     = 3
  max_size             = 3
  
  health_check_type    = "ELB"


  launch_configuration = aws_launch_configuration.exec-template.name

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  vpc_zone_identifier  = [aws_subnet.tv-public-1.id, aws_subnet.tv-public-2.id, aws_subnet.tv-public-3.id]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "exec-asg"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "ScaleinPolicy" {
  name                   = "ScaleinPolicy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.exec-asg.name
}

resource "aws_cloudwatch_metric_alarm" "bat" {
  alarm_name          = "terraform-exec"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = "120"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.exec-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.ScaleinPolicy.arn]
}

resource "aws_autoscaling_schedule" "SchedulePolicy" {
  scheduled_action_name  = "SchedulePolicy"
  min_size               = 0
  max_size               = 1
  desired_capacity       = 1
  start_time             = "2021-03-11T18:00:00Z"
  end_time               = "2021-03-12T06:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.exec-asg.name
}