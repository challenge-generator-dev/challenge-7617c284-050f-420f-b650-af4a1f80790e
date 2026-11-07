# Módulo de Terraform para ElastiCache Redis
# Superficie de práctica - Stub
# Este módulo provee el cache Redis para la API de pedidos

terraform {
  required_version = ">= 1.10.0"
}

# Grupo de subnets para ElastiCache
resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.project}-${var.environment}-redis-subnet"
  subnet_ids = var.subnet_ids
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis-subnet"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Security group para ElastiCache Redis
resource "aws_security_group" "redis" {
  name        = "${var.project}-${var.environment}-redis"
  description = "Security group para ElastiCache Redis"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port       = var.redis_port
    to_port         = var.redis_port
    protocol        = "tcp"
    security_groups = [var.allowed_security_group_id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis-sg"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Recurso de кластер ElastiCache Redis
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = var.replication_group_id
  replication_group_description = "Redis cluster for ${var.project} - ${var.environment}"
  
  engine               = "redis"
  engine_version       = var.engine_version
  node_type            = var.node_type
  number_cache_clusters = var.num_cache_nodes
  
  port                 = var.redis_port
  parameter_group_name = var.parameter_group_name
  
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [aws_security_group.redis.id]
  
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token_enabled         = var.auth_token_enabled
  
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled          = var.multi_az_enabled
  
  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_window           = var.snapshot_window
  maintenance_window        = var.maintenance_window
  
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately         = var.apply_immediately
  
  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  
  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# CloudWatch Log Group para Redis
resource "aws_elasticache_cloudwatch_log_group" "redis" {
  name              = "/aws/elasticache/${var.project}/${var.environment}/redis"
  retention_in_days = var.log_retention_days
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis-logs"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Outputs del módulo Redis
output "primary_endpoint" {
  description = "Endpoint primario del cluster Redis"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "reader_endpoint" {
  description = "Endpoint de lectura del cluster Redis"
  value       = aws_elasticache_replication_group.redis.reader_endpoint_address
}

output "port" {
  description = "Puerto de Redis"
  value       = aws_elasticache_replication_group.redis.port
}

output "replication_group_id" {
  description = "ID del grupo de replicación"
  value       = aws_elasticache_replication_group.redis.id
}

output "member_clusters" {
  description = "IDs de los nodos del cluster"
  value       = aws_elasticache_replication_group.redis.member_clusters
}