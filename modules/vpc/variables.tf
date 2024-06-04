variable "private_subnet_routes" {
  type        = list(string)
  description = "NAT gateway routes for the public route table"
  default = [
    "172.55.1.0/24"
  ]
}