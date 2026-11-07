# Configuración del proveedor de AWS y autenticación
# Se configura el backend remoto para el estado de Terraform

terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }

  backend "s3" {
    bucket         = "pedidos-app-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "pedidos-app-terraform-lock"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = merge(
      var.tags,
      {
        Project     = var.project_name
        Environment = var.environment
      }
    )
  }
}

# Configuración de Secrets Manager para manejar secrets de forma segura
resource "aws_secretsmanager_secret" "api_secrets" {
  name = "${var.project_name}-${var.environment}-api-secrets"
  recovery_window_in_days = 0
}

# Output del ARN del secret para ser usado por otros módulos
output "api_secrets_arn" {
  value = aws_secretsmanager_secret.api_secrets.arn
}

# Configuración de IAM Role para Lambda (requerido por el módulo de API)
resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.project_name}-${var.environment}-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Política básica para Lambda
resource "aws_iam_role_policy_attachment" "lambda_basic_exec" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Política adicional para Secrets Manager
resource "aws_iam_policy" "secrets_access" {
  name        = "${var.project_name}-${var.environment}-secrets-access"
  description = "Permite acceso a Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = aws_secretsmanager_secret.api_secrets.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_access_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.secrets_access.arn
}