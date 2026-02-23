###############################################
# Auto Scaling Group and Launch Template
###############################################

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

locals {
  effective_ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux2.id
}

resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.environment}-app-lt-"
  image_id      = local.effective_ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.app_sg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.environment}-app-instance"
      Environment = var.environment
    }
  }

  user_data = base64encode(var.user_data)
}


resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.environment}-app-asg"
  desired_capacity           = var.desired_capacity
  max_size                   = var.max_size
  min_size                   = var.min_size
  health_check_type           = "EC2"
  vpc_zone_identifier         = var.private_subnets

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "${var.environment}-app-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

