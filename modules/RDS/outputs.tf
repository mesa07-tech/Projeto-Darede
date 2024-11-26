output "rds_endpoint" {
  value       = aws_db_instance.testdb.endpoint
}

output "rds_port" {
  value       = aws_db_instance.testdb.port
}

output "rds_security_group_id" {
  value       = aws_security_group.rdssg.id
}