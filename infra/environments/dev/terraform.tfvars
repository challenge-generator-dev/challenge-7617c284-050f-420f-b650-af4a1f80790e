# Valores de variables para el entorno de desarrollo/pruebas
# Este archivo define la configuración específica del entorno de desarrollo
# para el aprovisionamiento de la infraestructura de la API de pedidos

# =============================================================================
# CONFIGURACIÓN GENERAL DEL PROYECTO
# =============================================================================

project     = "pedidos-app"
environment = "dev"
region      = "us-east-1"

# =============================================================================
# CONFIGURACIÓN DE LA API
# =============================================================================

api_instance_type = "t3.medium"
api_instance_count = 2
api_min_size = 2
api_max_size = 4
api_desired_capacity = 2
api_target_group_health_check_path = "/health"
api_health_check_interval_seconds = 30
api_health_check_timeout_seconds = 5
api_healthy_threshold_count = 2
api_unhealthy_threshold_count = 3

# =============================================================================
# CONFIGURACIÓN DE LA BASE DE DATOS (RDS PostgreSQL)
# =============================================================================

db_identifier              = "pedidos-dev-postgres"
db_name                    = "pedidos_dev"
db_username                = "pedidosadmin"
db_password                = "" # Se debe proporcionar via secrets manager o variable de entorno
db_instance_class          = "db.t3.micro"
db_allocated_storage       = 20
db_max_allocated_storage   = 100
db_port                    = 5432
db_engine_version          = "15.4"
db_backup_retention_period = 1
db_backup_window           = "03:00-04:00"
db_maintenance_window      = "mon:04:00-mon:05:00"
db_skip_final_snapshot     = true
db_deletion_protection     = false

# =============================================================================
# CONFIGURACIÓN DEL CACHE (ElastiCache Redis)
# =============================================================================

redis_replication_group_id    = "pedidos-dev-redis"
redis_node_type               = "cache.t3.micro"
redis_num_cache_nodes         = 2
redis_engine_version          = "7.0"
redis_port                    = 6379
redis_parameter_group_name    = "default.redis7"
redis_at_rest_encryption      = false
redis_transit_encryption      = false
redis_auth_token_enabled      = false
redis_automatic_failover      = false
redis_multi_az_enabled        = false
redis_snapshot_retention_limit = 0
redis_snapshot_window         = "03:00-04:00"
redis_maintenance_window      = "mon:05:00-mon:06:00"
redis_auto_minor_version_upgrade = true
redis_apply_immediately       = true
redis_log_retention_days      = 1

# =============================================================================
# CONFIGURACIÓN DE RED Y VPC
# =============================================================================

vpc_cidr_block           = "10.0.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.20.0/24"]
database_subnet_cidrs    = ["10.0.100.0/24", "10.0.110.0/24"]
redis_subnet_cidrs       = ["10.0.100.0/24", "10.0.110.0/24"]

# =============================================================================
# CONFIGURACIÓN DE TAGS OBLIGATORIOS
# =============================================================================

tags = {
  Environment = "dev"
  Project     = "pedidos-app"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Team        = "platform"
}

# =============================================================================
# CONFIGURACIÓN DE STATE REMOTO
# =============================================================================

terraform_backend_bucket = "pedidos-terraform-state-dev"
terraform_backend_dynamo_table = "terraform-state-locking-dev"

# =============================================================================
# CONFIGURACIÓN DE ALMACENAMIENTO (S3 para uploads)
# =============================================================================

s3_bucket_name        = "pedidos-dev-uploads"
s3_bucket_versioning = true
s3_bucket_encryption  = true

# =============================================================================
# CONFIGURACIÓN DE CERTIFICADO SSL/TLS
# =============================================================================

acm_certificate_domain = "api-dev.pedidos.example.com"

# =============================================================================
# CONFIGURACIÓN DE MONITOREO
# =============================================================================

enable_cloudwatch_metrics    = true
enable_cloudwatch_alarms     = true
log_retention_days          = 7

# =============================================================================
# NOTAS DE CONFIGURACIÓN
# =============================================================================
# Las contraseñas y secrets sensibles deben configurarse via:
# - AWS Secrets Manager
# - Variables de entorno de Terraform
# - terraform.tfvars.secrets (no versionar)
#
# Ejemplo de configuración de secrets:
# export TF_VAR_db_password="$(aws secretsmanager get-secret-value --secret-id pedidos/dev/db-password --query SecretString --output text)"
# export TF_VAR_api_secret_key="$(aws secretsmanager get-secret-value --secret-id pedidos/dev/api-secret --query SecretString --output text)"