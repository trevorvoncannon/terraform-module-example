resource "aws_security_group" "ec2-sg" {
  name        = "ec2-security-group"
  description = "Security group for ec2 instances"
  vpc_id      = var.vpc_ec2_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }
}


resource "aws_instance" "instance" {
  for_each      = var.ec2_instance
  ami           = each.value["ami"]
  instance_type = each.value["instance_type"]
  key_name      = each.value["key_name"]
  subnet_id     = each.value["subnet_id"]
  vpc_security_group_ids = [
    aws_security_group.ec2-sg.id
  ]

  root_block_device {
    volume_size = each.value["root_block_device_volume_size"]
    volume_type = each.value["root_block_device_volume_type"]
  }

  tags = {
    Name        = "${each.value["instance_name"]}"
  }
}