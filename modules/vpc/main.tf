data "aws_region" "current" {}

resource "aws_vpc_ipam" "ipam" {
  operating_regions {
    region_name = data.aws_region.current.name
  }
}

resource "aws_vpc_ipam_pool" "ipam_pool" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.ipam.private_default_scope_id
  locale         = data.aws_region.current.name
}

resource "aws_vpc_ipam_pool_cidr" "ipam_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.ipam_pool.id
  cidr         = "172.55.0.0/16"
}

resource "aws_vpc" "vpc" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.ipam_pool.id
  ipv4_netmask_length = 20
  depends_on = [
    aws_vpc_ipam_pool_cidr.ipam_cidr
  ]
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.55.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  #tags = {
  #  Name        = "${var.prefix}-igw"
  #}
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  depends_on    = [aws_internet_gateway.igw, aws_subnet.public]
  #tags = {
  #  Name        = "${var.prefix}-natgw"
  #}
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "us-west-2b"
  cidr_block        = "172.55.2.0/24"
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "us-west-2c"
  cidr_block        = "172.55.3.0/24"
}

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block        = "0.0.0.0/0"
    nat_gateway_id     = aws_nat_gateway.nat_gw.id
  }
  #tags = {
  #  Name        = "${var.prefix}-private-rt"
  #}
}

resource "aws_route_table" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id        = aws_internet_gateway.igw.id
  }
  #tags = {
  #  Name        = "${var.prefix}-public-rt"
  #}
}

