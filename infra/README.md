# Infraestructura API de Pedidos

Este módulo aprovisiona la infraestructura necesaria para la API de la aplicación móvil de pedidos.

## Requisitos previos

- Terraform >= 1.10.0
- AWS CLI configurado con credenciales
- Cuenta de AWS con permisos para crear recursos

## Estructura del módulo

```
infra/
├── main.tf          # Orquestación de recursos
├── outputs.tf       # Exportación de recursos aprovisionados
├── variables.tf     # Variables de configuración (generado en otro lote)
├── providers.tf     # Configuración del provider (generado en otro lote)
├── versions.tf      # Restricciones de versión (generado en otro lote)
└── modules/
    ├── api/         # Módulo de API
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── security.tf
    ├── database/    # Módulo de base de datos
    │   ├── main.tf
    │   └── variables.tf
    └── cache/       # Módulo de caché
        └── main.tf
```

## Uso básico

### Inicializar Terraform

```bash
cd infra
terraform init
```

### Validar configuración

```bash
terraform validate
```

### Planificar cambios

```bash
terraform plan -var-file=../environments/dev/terraform.tfvars
```

### Aplicar cambios

```bash
terraform apply -var-file=../environments/dev/terraform.tfvars
```

### Destruir recursos

```bash
terraform destroy -var-file=../environments/dev/terraform.tfvars
```

## Variables requeridas

Las variables se definen en `variables.tf` y se configuran en los archivos `terraform.tfvars` de cada entorno.

- `aws_region`: Región de AWS
- `environment`: Entorno (dev, staging, prod)
- `project_name`: Nombre del proyecto
- `vpc_cidr`: CIDR de la VPC
- `api_subnet_cidrs`: Subnets para la API
- `db_subnet_cidrs`: Subnets para la base de datos
- `api_instance_type`: Tipo de instancia para API
- `db_instance_type`: Tipo de instancia para base de datos

## Recursos aprovisionados

Este módulo crea los siguientes recursos:

- VPC con subnets públicas y privadas
- Grupo de Auto Scaling para la API
- Balanceador de carga (ALB)
- Instancia de base de datos (RDS PostgreSQL)
- ElastiCache Redis para caché
- Security groups para cada componente
- IAM roles y políticas
- Secretos en AWS Secrets Manager

## Outputs disponibles

Los outputs exponen la información necesaria para conectar la aplicación móvil:

- `api_url`: URL del endpoint de la API
- `api_arn`: ARN del API Gateway
- `database_endpoint`: Endpoint de la base de datos
- `cache_endpoint`: Endpoint de Redis
- `security_group_ids`: IDs de los security groups

## Verificación

Para verificar que la infraestructura está correctamente aprovisionada:

```bash
# Verificar estado de Terraform
terraform show

# Verificar recursos en AWS
aws ec2 describe-vpcs --region $AWS_REGION
aws rds describe-db-instances --region $AWS_REGION
```

## Limpieza

Para eliminar todos los recursos creados:

```bash
terraform destroy -var-file=../environments/dev/terraform.tfvars
```

**Advertencia**: Esta operación elimina todos los recursos de AWS creados por este módulo.

## Referencias

- Documentación de Terraform: https://www.terraform.io/docs
- Documentación de AWS Provider: https://registry.terraform.io/providers/hashicorp/aws
- Best Practices de AWS: https://aws.amazon.com/architecture/well-architected/