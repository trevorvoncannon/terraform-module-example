output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_public_id" {
    value = aws_subnet.public.id
}

output "subnet_private_id" {
    value = aws_subnet.private.id
}

output "subnet_private2_id" {
    value = aws_subnet.private2.id
}
