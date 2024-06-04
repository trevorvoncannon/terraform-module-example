resource "aws_security_group" "db_sg" {
  vpc_id      = "vpc-04419b8bfcd67c7a6"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.55.1.0/24"]
  }
}

resource "aws_db_subnet_group" "db_sng" {
  name       = "test-sng"
  subnet_ids = ["subnet-08c9d5a8db59ee4d6", "subnet-0b7dd58cf10b674d0"]
}

resource "aws_db_instance" "db" {
  depends_on           = [aws_db_subnet_group.db_sng]
  allocated_storage    = 10
  db_name              = "testdb"
  db_subnet_group_name = aws_db_subnet_group.db_sng.id
  engine               = "postgres"
  engine_version       = "16.2"
  instance_class       = "db.t3.micro"
  username             = ""
  password             = ""
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}