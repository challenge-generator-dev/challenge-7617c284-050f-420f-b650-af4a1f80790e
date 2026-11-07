# Configuración de versiones de Terraform y proveedores
# Superficie de práctica - completar por el estudiante

terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}