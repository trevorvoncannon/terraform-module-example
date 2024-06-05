variable ec2_instance {
  type = map(object({
  instance_name = string
  ami           = string
  instance_type = string
  key_name      = string
  subnet_id     = string
  root_block_device_volume_size = number
  root_block_device_volume_type = string
  }))
}

variable vpc_ec2_id {
    type = string
}

variable ssh_cidr {
    type = string
}
