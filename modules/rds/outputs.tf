output "db_address" {
    value = {for k, v in aws_db_instance.db: k => v.address}
}

output "db_port" {
    value = {for k, v in aws_db_instance.db: k => v.port}
}

output "db_engine" {
    value = {for k, v in aws_db_instance.db: k => v.engine}
}