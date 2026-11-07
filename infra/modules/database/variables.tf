# Variables del módulo de base de datos
# Estas variables permiten personalizar el despliegue de la base de datos

variable "project_name" {
  description = "Nombre del proyecto. Usado para nombrar recursos."
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)."
  type        = string
}

variable "database_name" {
  description = "Nombre de la base de datos."
  type        = string
  default     = "pedidosdb"
}

variable "database_username" {
  description = "Usuario maestro de la base de datos."
  type        = string
  default     = "admin"
}

variable "database_password" {
  description = "Contraseña del usuario maestro de la base de datos."
  type        = string
  sensitive   = true
}

variable "database_engine" {
  description = "Motor de base de datos (postgres, mysql)."
  type        = string
  default     = "postgres"
}

variable "database_engine_version" {
  description = "Versión del motor de base de datos."
  type        = string
  default     = "13.4"
}

variable "database_instance_class" {
  description = "Clase de instancia para la base de datos."
  type        = string
  default     = "db.t3.micro"
}

variable "database_allocated_storage" {
  description = "Almacenamiento asignado en GB."
  type        = number
  default     = 20
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará la base de datos."
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subnets para el grupo de subnets de la base de datos."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para la base de datos."
  type        = list(string)
  default     = []
}