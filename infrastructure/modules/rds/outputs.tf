output "endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.this.address
}

output "db_name" {
  description = "RDS database name"
  value       = aws_db_instance.this.db_name
}
