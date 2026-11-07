# Módulo de Terraform para la API del backend de pedidos
# Superficie de práctica: el estudiante debe implementar los recursos de infraestructura

# ============================================
# Configuración del módulo API
# ============================================

terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

# ============================================
# Variables del módulo (definidas en variables.tf del módulo)
# ============================================

# Variables esperadas:
# - environment (string)
# - vpc_id (string)
# - subnet_ids (list(string))
# - alb_security_group_id (string)
# - db_instance_id (string)
# - ecs_cluster_name (string)
# - api_image (string)
# - api_container_port (number)
# - api_env_vars (map(string))

# ============================================
# ECS Task Definition para la API
# ============================================

resource "aws_ecs_task_definition" "api_task" {
  # TODO: Implementar task definition completa
  # - family: api-task-${var.environment}
  # - network_mode: awsvpc
  # - requires_compatibilities: ["FARGATE"]
  # - cpu, memory
  # - container_definitions con el contenedor de la API
  # - execution_role_arn y task_role_arn
  # - tags obligatorios

  lifecycle {
    create_before_destroy = true
  }
}

# ============================================
# ECS Service para la API
# ============================================

resource "aws_ecs_service" "api_service" {
  # TODO: Implementar el servicio ECS
  # - name: api-service-${var.environment}
  # - cluster: var.ecs_cluster_name
  # - task_definition: aws_ecs_task_definition.api_task.arn
  # - desired_count: 2
  # - launch_type: FARGATE
  # - network_configuration (subnets, security groups)
  # - load_balancer (target group ARN)
  # - deployment_configuration
  # - health_check_grace_period_seconds
  # - tags obligatorios

  depends_on = ["aws_lb_target_group", "aws_lb_listener"]
}

# ============================================
# ALB: Target Group para la API
# ============================================

resource "aws_lb_target_group" "api_target_group" {
  # TODO: Implementar target group
  # - name: api-tg-${var.environment}
  # - port: 80
  # - protocol: HTTP
  # - vpc_id: var.vpc_id
  # - target_type: ip
  # - health_check (path: /health, matcher: 200)
  # - deregistration_delay: 30
  # - tags obligatorios
}

# ============================================
# ALB: Listener HTTP para la API
# ============================================

resource "aws_lb_listener" "api_http" {
  # TODO: Implementar listener HTTP (redirección a HTTPS en producción)
  # - load_balancer_arn: referenciar ALB
  # - port: 80
  # - protocol: HTTP
  # - default_action: forward a target group
  # - tags obligatorios
}

# ============================================
# ALB: Listener HTTPS para la API (producción)
# ============================================

resource "aws_lb_listener" "api_https" {
  # TODO: Implementar listener HTTPS con certificado ACM
  # - load_balancer_arn: referenciar ALB
  # - port: 443
  # - protocol: HTTPS
  # - certificate_arn: var.acm_certificate_arn
  # - default_action: forward a target group
  # - ssl_policy: ELBSecurityPolicy-2016-08
  # - tags obligatorios
}

# ============================================
# ALB: Reglas del Listener para routing
# ============================================

resource "aws_lb_listener_rule" "api_orders" {
  # TODO: Implementar regla para /api/orders
  # - listener_arn: aws_lb_listener.api_https.arn
  # - priority: 10
  # - condition: path_pattern /api/orders*
  # - action: forward a target group
}

resource "aws_lb_listener_rule" "api_products" {
  # TODO: Implementar regla para /api/products
  # - listener_arn: aws_lb_listener.api_https.arn
  # - priority: 20
  # - condition: path_pattern /api/products*
  # - action: forward a target group
}

resource "aws_lb_listener_rule" "api_health" {
  # TODO: Implementar regla para /health (sin autenticación)
  # - listener_arn: aws_lb_listener.api_https.arn
  # - priority: 5
  # - condition: path_pattern /health
  # - action: forward a target group
}

# ============================================
# IAM: Rol de ejecución de tareas ECS
# ============================================

resource "aws_iam_role" "ecs_execution_role" {
  # TODO: Implementar rol de ejecución
  # - name: ecs-execution-role-${var.environment}
  # - assume_role_policy: servicio ECS
  # - tags obligatorios
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  # TODO: Adjuntar política AmazonECSTaskExecutionRolePolicy
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ============================================
# IAM: Rol de tarea ECS (para acceso a recursos)
# ============================================

resource "aws_iam_role" "ecs_task_role" {
  # TODO: Implementar rol de tarea
  # - name: ecs-task-role-${var.environment}
  # - assume_role_policy: servicio ECS
  # - inline policy para Secrets Manager
  # - tags obligatorios
}

# ============================================
# CloudWatch: Log Group para la API
# ============================================

resource "aws_cloudwatch_log_group" "api_logs" {
  # TODO: Implementar grupo de logs
  # - name: /ecs/api-${var.environment}
  # - retention_in_days: 7
  # - tags obligatorios
}

# ============================================
# Variables de entorno para el contenedor
# ============================================

locals {
  default_env_vars = {
    "ENVIRONMENT"     = var.environment
    "API_BASE_URL"    = "https://api-dev.pedidos.example.com"
    "DB_HOST"         = var.db_host
    "DB_PORT"         = var.db_port
    "DB_NAME"         = var.db_name
    "LOG_LEVEL"       = "info"
  }

  # Combinar con variables de entorno personalizadas
  container_env_vars = merge(local.default_env_vars, var.api_env_vars)
}