variable db_instance {
  type = map(object({
  allocated_storage   = number
  db_name             = string
  engine              = string
  engine_version      = string
  instance_class      = string
  username            = string
  password            = string
  skip_final_snapshot = bool
  }))
}

variable private_subnet_1 {
    type = string
}

variable private_subnet_2 {
    type = string
}

variable public_cidr_block {
    type = string
}

variable vpc_id {
    type = string
}

variable ec2_security_group {
    type = string
}