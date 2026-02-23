# -------------------------------------------
#  Application Load Balancer (ALB)
# -------------------------------------------

# 1️⃣ Security Group for the ALB


#resource "aws_security_group" "alb_sg" {
#name        = "dev-alb-sg"
#description = "Allow HTTP inbound traffic"
#vpc_id      = var.vpc_id

#ingress {
# from_port   = 80
# to_port     = 80
#protocol    = "tcp"
# cidr_blocks = ["0.0.0.0/0"] # public access
#}

#egress {
#from_port   = 0
# to_port     = 0
# protocol    = "-1"
# cidr_blocks = ["0.0.0.0/0"]
#}

#tags = {
#  Name = "dev-alb-sg"
# }
#}

# 2️⃣ Create the Load Balancer
resource "aws_lb" "app_alb" {
  name               = "dev-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets_ids

  tags = {
    Name = "dev-app-alb"
  }
}

# 3️⃣ Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = "dev-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "dev-app-tg"
  }
}

# 4️⃣ Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

