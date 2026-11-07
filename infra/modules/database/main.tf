# Módulo de Terraform para RDS PostgreSQL
# Superficie de práctica - Stub
# Este módulo provee la base de datos PostgreSQL para la API de pedidos

terraform {
  required_version = ">= 1.10.0"
}

# Configuración del recurso RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  identifier     = var.db_identifier
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class
  
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  
  port = var.port
  
  vpc_security_group_ids = [var.security_group_id]
  
  db_subnet_group_name = var.subnet_group_name
  
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  
  deletion_protection = var.deletion_protection
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-postgres"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Output para la conexión de la base de datos
output "connection_string" {
  description = "Cadena de conexión a la base de datos PostgreSQL"
  value       = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.postgres.endpoint}/${var.db_name}"
  sensitive   = true
}

output "endpoint" {
  description = "Endpoint de la base de datos"
  value       = aws_db_instance.postgres.endpoint
}

output "port" {
  description = "Puerto de la base de datos"
  value       = aws_db_instance.postgres.port
}

output "arn" {
  description = "ARN de la instancia RDS"
  value       = aws_db_instance.postgres.arn
}