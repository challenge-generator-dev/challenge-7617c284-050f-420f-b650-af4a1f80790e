# Variables del módulo de API
# Estas variables permiten personalizar el despliegue del API Gateway y Lambdas

variable "project_name" {
  description = "Nombre del proyecto. Usado para nombrar recursos."
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)."
  type        = string
}

variable "api_domain" {
  description = "Dominio base para la API."
  type        = string
}

variable "health_check_path" {
  description = "Ruta para el health check de la API."
  type        = string
}

variable "api_routes" {
  description = "Rutas de la API que deben ser configuradas."
  type = map(object({
    path    = string
    methods = list(string)
  }))
}

variable "lambda_exec_role_arn" {
  description = "ARN del rol de IAM para ejecución de Lambdas."
  type        = string
}

variable "api_secrets_arn" {
  description = "ARN del secret en Secrets Manager que contiene las credenciales de la API."
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará la API."
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subnets para desplegar recursos."
  type        = list(string)
}