#database

locals {
  instance_tag = "by-terraform"
}

// Picking exsisting key

data "aws_key_pair" "pro-key" {
  filter {
    name = "tag:purpose"
    values = ["project"]
  }
}
	
resource "aws_instance" "database-instance" {
  ami           = var.ami-db
  instance_type = var.instance-db
  key_name = data.aws_key_pair.pro-key.key_name
  private_ip = var.privateip-db
  subnet_id = var.subnet-db
  vpc_security_group_ids = [var.sg-db]
  user_data = filebase64("${path.module}/userdata.sh")
  tags = {
		Name = "database-test"
	}
}
