resource "aws_security_group" "ec2-sg" {
  name        = "ec2-security-group"
  description = "Security group for ec2 instances"
  vpc_id      = "vpc-04419b8bfcd67c7a6"

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
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "instance" {
  ami           = "ami-0eb9d67c52f5c80e5"
  instance_type = "t2.micro"
  key_name      = "NOC"
  subnet_id     = "subnet-04d918f7993678f7e"
  vpc_security_group_ids = [
    aws_security_group.ec2-sg.id
  ]

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  #tags = {
  #  Name        = "${var.instance_name}"
  #}
}