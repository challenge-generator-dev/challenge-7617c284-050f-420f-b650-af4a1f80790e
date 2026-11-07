# Outputs del módulo de API
# Superficie de práctica: el estudiante debe definir los outputs correctos

# ============================================
# Outputs del ALB
# ============================================

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.api_alb.arn
}

output "alb_dns_name" {
  description = "DNS nombre del ALB para acceder a la API"
  value       = aws_lb.api_alb.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para Route 53"
  value       = aws_lb.api_alb.zone_id
}

output "target_group_arn" {
  description = "ARN del Target Group de la API"
  value       = aws_lb_target_group.api_target_group.arn
}

output "listener_http_arn" {
  description = "ARN del listener HTTP"
  value       = aws_lb_listener.api_http.arn
}

output "listener_https_arn" {
  description = "ARN del listener HTTPS"
  value       = aws_lb_listener.api_https.arn
}

# ============================================
# Outputs del ECS
# ============================================

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.api_service.name
}

output "ecs_task_definition_arn" {
  description = "ARN de la task definition"
  value       = aws_ecs_task_definition.api_task.arn
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = var.ecs_cluster_name
}

# ============================================
# Outputs de IAM
# ============================================

output "ecs_execution_role_arn" {
  description = "ARN del rol de ejecución de ECS"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN del rol de tarea de ECS"
  value       = aws_iam_role.ecs_task_role.arn
}

# ============================================
# Outputs de CloudWatch
# ============================================

output "log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.api_logs.name
}

# ============================================
# Outputs de URLs de la API
# ============================================

output "api_base_url" {
  description = "URL base de la API"
  value       = "https://api-dev.pedidos.example.com"
}

output "api_health_url" {
  description = "URL del endpoint de health check"
  value       = "https://api-dev.pedidos.example.com/health"
}

output "api_orders_url" {
  description = "URL base del endpoint de pedidos"
  value       = "https://api-dev.pedidos.example.com/api/orders"
}

output "api_products_url" {
  description = "URL base del endpoint de productos"
  value       = "https://api-dev.pedidos.example.com/api/products"
}

# ============================================
# Outputs de seguridad
# ============================================

output "api_security_group_id" {
  description = "ID del grupo de seguridad de la API"
  value       = aws_security_group.api_sg.id
}

output "ecs_task_security_group_id" {
  description = "ID del grupo de seguridad de las tareas ECS"
  value       = aws_security_group.ecs_tasks_sg.id
}