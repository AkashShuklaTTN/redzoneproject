resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public-sg.id]
  subnets            = [var.subnet1, var.subnet2]

  enable_deletion_protection = true


  tags = {
    Environment = "production"
  }
}

resource "aws_security_group" "public-sg" {
    name   = "public-sg"
    vpc_id = var.vpc-id
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.test-ip]
    }
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.test-ip]
    }
    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = [var.vpc-cidr]
    }
  ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = [var.test-ip]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }

resource "aws_security_group" "private-sg" {
 name = "private-sg"
 vpc_id = var.vpc-id
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
     }
     egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = var.asg-attach
  lb_target_group_arn   = aws_lb_target_group.examples.arn
}

resource "aws_lb_target_group" "examples" {
  name        = "tf-example-lb-tg"
  target_type = "instance"
  port        = 8080
  protocol    = "TCP"
  vpc_id      = var.vpc-id
}


