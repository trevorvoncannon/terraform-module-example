resource "aws_security_group" "db_sg" {
  vpc_id      = var.vpc_id
  name        = "db-sg"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [var.ec2_security_group]
  }
}

resource "aws_db_subnet_group" "db_sng" {
  name       = "test-sng"
  subnet_ids = [var.private_subnet_1, var.private_subnet_2]
}

resource "aws_db_instance" "db" {
  for_each             = var.db_instance
  depends_on           = [aws_db_subnet_group.db_sng]
  allocated_storage    = each.value["allocated_storage"]
  db_name              = each.value["db_name"]
  db_subnet_group_name = aws_db_subnet_group.db_sng.id
  engine               = each.value["engine"]
  engine_version       = each.value["engine_version"]
  instance_class       = each.value["instance_class"]
  username             = each.value["username"]
  password             = each.value["password"]
  skip_final_snapshot  = each.value["skip_final_snapshot"]
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  tags = {
    Name        = each.value["db_name"]
  }
}