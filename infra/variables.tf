# Variables globales para personalización del entorno
# Estos valores se pasan desde terraform.tfvars o desde la línea de comandos

variable "project_name" {
  description = "Nombre del proyecto. Usado para taggear recursos."
  type        = string
  default     = "pedidos-app"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Región de AWS donde se desplegarán los recursos."
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags adicionales para los recursos."
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}

variable "api_domain" {
  description = "Dominio base para la API."
  type        = string
  default     = "api-dev.pedidos.example.com"
}

variable "health_check_path" {
  description = "Ruta para el health check de la API."
  type        = string
  default     = "/health"
}

variable "api_routes" {
  description = "Rutas de la API que deben ser configuradas."
  type = map(object({
    path = string
    methods = list(string)
  }))
  default = {
    orders = {
      path    = "/api/orders"
      methods = ["GET", "POST"]
    },
    products = {
      path    = "/api/products"
      methods = ["GET", "POST"]
    }
  }
}