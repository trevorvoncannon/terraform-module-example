ipam_cidr            = "172.30.0.0/16"
vpc_netmask_length   = 20
public_az            = "us-west-2b"
public_cidr_block    = "172.30.1.0/24"
private_az           = "us-west-2b"
private_cidr_block   = "172.30.2.0/24"
private_2_az         = "us-west-2c"
private_2_cidr_block = "172.30.3.0/24"
ssh_cidr             = "175.55.0.0/16"

ec2_instance = {
  "instance" = {
    instance_name = "test-instance"
    ami           = "ami-0eb9d67c52f5c80e5"
    instance_type = "t2.micro"
    key_name      = "mykey"
    subnet_id     = "subnet-04d918f7993678f7e"
    ssh_cidr      = "172.30.0.0/16"
    root_block_device_volume_size = 20
    root_block_device_volume_type = "gp3"
  }
  "instance-2" = {
    instance_name = "test-instance-2"
    ami           = "ami-0eb9d67c52f5c80e5"
    instance_type = "t2.micro"
    key_name      = "mykey"
    subnet_id     = "subnet-04d918f7993678f7e"
    ssh_cidr      = "172.30.0.0/16"
    root_block_device_volume_size = 20
    root_block_device_volume_type = "gp3"
  }
}

db_instance = {
  "db1" = {
  allocated_storage   = 30
  db_name             = "testdb"
  engine              = "postgres"
  engine_version      = "16.2"
  instance_class      = "db.t3.micro"
  username            = "username"
  password            = "password"
  skip_final_snapshot = true
  }
  "db2" = {
  allocated_storage   = 30
  db_name             = "testdb2"
  engine              = "postgres"
  engine_version      = "16.2"
  instance_class      = "db.t3.micro"
  username            = "username"
  password            = "password"
  skip_final_snapshot = true
  }
}