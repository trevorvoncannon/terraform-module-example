output "instance_id" {
    value = {for k, v in aws_instance.instance: k => v.id}
}

output "instance_private_ip" {
    value = {for k, v in aws_instance.instance: k => v.private_ip}
}

output "instance_public_ip" {
    value = {for k, v in aws_instance.instance: k => v.public_ip}
}

output "ec2-sg" {
    value = aws_security_group.ec2-sg.id
}