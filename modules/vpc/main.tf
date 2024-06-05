data "aws_region" "current" {}

resource "aws_vpc_ipam" "ipam" {
  operating_regions {
    region_name = "us-west-2"
  }
}

resource "aws_vpc_ipam_pool" "ipam_pool" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.ipam.private_default_scope_id
  locale         = data.aws_region.current.name
}

resource "aws_vpc_ipam_pool_cidr" "ipam_cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.ipam_pool.id
  cidr         = var.ipam_cidr
}

resource "aws_vpc" "vpc" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.ipam_pool.id
  ipv4_netmask_length = var.vpc_netmask_length
  depends_on = [
    aws_vpc_ipam_pool_cidr.ipam_cidr
  ]
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.public_az
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${aws_vpc.vpc.id}-igw"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.private_az
  cidr_block        = var.private_cidr_block
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.private_2_az
  cidr_block        = var.private_2_cidr_block
}


resource "aws_route_table" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id        = aws_internet_gateway.igw.id
  }
  tags = {
    Name        = "${aws_vpc.vpc.id}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.internet_gateway.id
}

