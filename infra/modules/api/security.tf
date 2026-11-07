# Configuración de seguridad: grupos de seguridad y políticas IAM
# Superficie de práctica: el estudiante debe implementar las políticas correctas

# ============================================
# Grupo de seguridad para el ALB
# ============================================

resource "aws_security_group" "alb_sg" {
  # TODO: Implementar grupo de seguridad del ALB
  # - name: alb-sg-{var.environment}
  # - description: Security group para el ALB de la API
  # - vpc_id: var.vpc_id
  # - ingress:
  #   - HTTPS desde internet (0.0.0.0/0)
  #   - HTTP desde internet (0.0.0.0/0) para redirect
  # - egress: todo el tráfico a las tareas ECS
  # - tags obligatorios: Environment, Project, ManagedBy
}

# ============================================
# Grupo de seguridad para las tareas ECS (API)
# ============================================

resource "aws_security_group" "ecs_tasks_sg" {
  # TODO: Implementar grupo de seguridad de las tareas ECS
  # - name: ecs-tasks-sg-{var.environment}
  # - description: Security group para las tareas de la API
  # - vpc_id: var.vpc_id
  # - ingress:
  #   - TCP desde el ALB (puerto del container)
  # - egress:
  #   - HTTPS a AWS services
  #   - TCP a la base de datos (puerto 5432)
  #   - TCP a ElastiCache (puerto 6379)
  # - tags obligatorios: Environment, Project, ManagedBy
}

# ============================================
# Grupo de seguridad para la API (alias)
# ============================================

resource "aws_security_group" "api_sg" {
  # Grupo de seguridad principal de la API
  name        = "api-sg-${var.environment}"
  description = "Grupo de seguridad principal para la API de pedidos"
  vpc_id      = var.vpc_id

  # Ingress: tráfico del ALB al contenedor
  ingress {
    description     = "Tráfico del ALB al contenedor API"
    from_port       = var.api_container_port
    to_port         = var.api_container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Egress: tráfico a servicios externos y base de datos
  egress {
    description      = "Tráfico saliente a Internet y servicios AWS"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Environment = var.environment
    Project     = "pedidos-app"
    ManagedBy   = "terraform"
    Name        = "api-sg-${var.environment}"
  }
}

# ============================================
# Política IAM: acceso a Secrets Manager
# ============================================

resource "aws_iam_policy" "secrets_manager_access" {
  # TODO: Implementar política de acceso a Secrets Manager
  # - name: secrets-manager-access-{var.environment}
  # - description: Permiso para leer secretos de la API
  # - policy: permite GetSecretValue en los secretos de la API
  # - tags obligatorios
}

resource "aws_iam_role_policy_attachment" "ecs_task_secrets" {
  # Adjuntar política de Secrets Manager al rol de tarea
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.secrets_manager_access.arn
}

# ============================================
# Política IAM: acceso a CloudWatch Logs
# ============================================

resource "aws_iam_policy" "cloudwatch_logs_access" {
  # Política para escribir logs en CloudWatch
  name        = "cloudwatch-logs-access-${var.environment}"
  description = "Permiso para escribir logs de la API en CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.api_logs.arn}:*"
      }
    ]
  })

  tags = {
    Environment = var.environment
    Project     = "pedidos-app"
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_logs" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_access.arn
}

# ============================================
# Política IAM: acceso a SSM Parameter Store
# ============================================

resource "aws_iam_policy" "ssm_parameter_access" {
  # TODO: Implementar política de acceso a Parameter Store
  # - name: ssm-parameter-access-{var.environment}
  # - description: Permiso para leer parámetros de configuración
  # - policy: permite GetParameters en los parámetros de la API
  # - tags obligatorios
}

resource "aws_iam_role_policy_attachment" "ecs_task_ssm" {
  # Adjuntar política de SSM al rol de tarea
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ssm_parameter_access.arn
}

# ============================================
# Política IAM: acceso a S3 (si es necesario)
# ============================================

resource "aws_iam_policy" "s3_bucket_access" {
  # TODO: Implementar política de acceso a S3 si la API necesita almacenamiento
  # - name: s3-access-{var.environment}
  # - description: Permiso para acceder al bucket S3 de la API
  # - policy: permisos específicos según necesidad
  # - tags obligatorios
}

# ============================================
# Security Group Rule: acceso a RDS
# ============================================

resource "aws_vpc_security_group_ingress_rule" "rds_from_api" {
  # TODO: Regla de ingress desde la API a la base de datos RDS
  # - security_group_id: ID del security group de RDS
  # - from_port: 5432 (PostgreSQL)
  # - to_port: 5432
  # - protocol: tcp
  # - referenced_security_group_id: aws_security_group.ecs_tasks_sg.id
}

# ============================================
# Security Group Rule: acceso a ElastiCache
# ============================================

resource "aws_vpc_security_group_ingress_rule" "elasticache_from_api" {
  # TODO: Regla de ingress desde la API a ElastiCache (Redis)
  # - security_group_id: ID del security group de ElastiCache
  # - from_port: 6379 (Redis)
  # - to_port: 6379
  # - protocol: tcp
  # - referenced_security_group_id: aws_security_group.ecs_tasks_sg.id
}

# ============================================
# Outputs de seguridad para otros módulos
# ============================================

output "alb_security_group_id" {
  description = "ID del grupo de seguridad del ALB"
  value       = aws_security_group.alb_sg.id
}

output "api_security_group_id" {
  description = "ID del grupo de seguridad de la API"
  value       = aws_security_group.api_sg.id
}

output "ecs_tasks_security_group_id" {
  description = "ID del grupo de seguridad de las tareas ECS"
  value       = aws_security_group.ecs_tasks_sg.id
}

output "secrets_manager_policy_arn" {
  description = "ARN de la política de acceso a Secrets Manager"
  value       = aws_iam_policy.secrets_manager_access.arn
}

output "ssm_parameter_policy_arn" {
  description = "ARN de la política de acceso a SSM Parameter Store"
  value       = aws_iam_policy.ssm_parameter_access.arn
}