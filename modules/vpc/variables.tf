variable "ipam_cidr" {
  type        = string
  description = "CIDR block to allocate in IPAM"
}

variable "vpc_netmask_length" {
  type        = number
  description = "VPC netmask length (ex 8, 16, 18, 20, 24, 28)"
}

variable "public_az" {
  type        = string
  description = "Availability zone for public subnet"
}

variable "public_cidr_block" {
  type        = string
  description = "CIDR block for public subnet"
}

variable "private_az" {
  type        = string
  description = "Availability zone for private subnet"
}

variable "private_cidr_block" {
  type        = string
  description = "CIDR block for private subnet"
}

variable "private_2_az" {
  type        = string
  description = "Availability zone for private_2 subnet"
}

variable "private_2_cidr_block" {
  type        = string
  description = "CIDR block for private_2 subnet"
}