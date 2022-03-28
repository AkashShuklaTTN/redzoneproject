#asg



data "aws_key_pair" "project-key" {
  filter {
    name = "tag:purpose"
    values = ["project"]
  }
}  
  
resource "aws_launch_template" "app-temp" {
  name_prefix = "ttn-"
  key_name  = data.aws_key_pair.project-key.key_name
  image_id    = var.ami_id
  instance_type = var.instance_type
  user_data     = filebase64("${path.module}/tomcat.sh")
}

resource "aws_autoscaling_group" "app-asg" {
  name               = "Application-asg"
  desired_capacity   = var.desired_cap
  max_size           = var.max_count
  min_size           = var.min_count
  vpc_zone_identifier = [var.subnet1_id, var.subnet2_id]

  launch_template {
    id      = aws_launch_template.app-temp.id
    version = "$Latest"
}

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = var.min_healthy
    }
}
}


