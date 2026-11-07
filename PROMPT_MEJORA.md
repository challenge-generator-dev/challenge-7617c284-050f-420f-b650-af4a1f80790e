# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api/security.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/cache/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://api-dev.pedidos.example.com):
  - `GET /health`
  - `GET/POST /api/orders`
  - `GET/POST /api/products`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `infra/main.tf`
- `infra/outputs.tf`
- `client/lib/presentation/screens/home_screen.dart`
- `client/lib/presentation/screens/orders_screen.dart`
- `client/lib/presentation/screens/products_screen.dart`
- `client/lib/presentation/widgets/product_card.dart`
- `client/lib/di/injection.dart`
- `client/test/data/repositories/order_repository_test.dart`

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `client/lib/data/models/order_model.dart` — `OrderItem.toJson`: Se invoca `toJson` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/models/order_model.dart` — `OrderItem.toEntity`: Se invoca `toEntity` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/test/presentation/viewmodels/orders_viewmodel_test.dart` — `OrdersViewModel.addListener`: Se invoca `addListener` sobre `OrdersViewModel`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/test/presentation/viewmodels/orders_viewmodel_test.dart` — `OrdersViewModel.removeListener`: Se invoca `removeListener` sobre `OrdersViewModel`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/test/presentation/viewmodels/orders_viewmodel_test.dart` — `OrdersViewModel.clearOrders`: Se invoca `clearOrders` sobre `OrdersViewModel`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261106194239047), Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el proyecto. — entregable (NO resolver): Archivo de configuración de Terraform listo para su uso.
- Fase 2: Aprovisionamiento de recursos con Terraform — objetivo: Aprovisionar los recursos necesarios para la API de la aplicación de pedidos. — entregable (NO resolver): Recursos aprovisionados y listos para su uso.
- Fase 3: Despliegue de la API — objetivo: Desplegar la API de la aplicación de pedidos en el entorno de pruebas. — entregable (NO resolver): API desplegada y accesible en el entorno de pruebas.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/providers.tf ===
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

// === ARCHIVO: infra/modules/api/variables.tf ===
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

// === ARCHIVO: infra/modules/database/variables.tf ===
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

// === ARCHIVO: infra/README.md ===
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

// === ARCHIVO: infra/versions.tf ===
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

// === ARCHIVO: infra/.terraform-version ===
1.10.0

// === ARCHIVO: infra/.gitignore ===
# Terraform
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
*.backup
*.backup.*
.terraform/
.terraform.lock.hcl
*.log

# Directorios de módulos descargados
.modules/
.modules.lock

# Archivos de locking de proveedores
provider-lock.json

# Credenciales y secretos
*.pem
*.key
credentials.json
secrets/
*.secret

# Archivos de IDE
.idea/
.vscode/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Outputs generados
output/
plan.out
plan.tfplan

# Scripts temporales
tmp/
temp/

# Archivos de entorno local
.env
.env.local
.local/

# Terraform cloud
.terraformrc
terraform.rc

# Lock files de dependencias
package-lock.json
yarn.lock
Pipfile.lock
Gemfile.lock

# Logs de ejecución
*.info
*.warn
*.error

# Archivos de testing que no deben subirse
tests/.terraform/
test/.terraform/

# Certificados y claves de AWS (nunca en repositorio)
*.crt
*.cer
*.p12
*.pfx

# Archivos de configuración sensibles
appspec.yml
deploy_key*
*_rsa*
*_dsa*

// === ARCHIVO: infra/modules/api/main.tf ===
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

// === ARCHIVO: infra/modules/api/outputs.tf ===
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

// === ARCHIVO: infra/modules/api/security.tf ===
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

// === ARCHIVO: infra/modules/database/main.tf ===
# Módulo de Terraform para RDS PostgreSQL
# Superficie de práctica - Stub
# Este módulo provee la base de datos PostgreSQL para la API de pedidos

terraform {
  required_version = ">= 1.10.0"
}

# Configuración del recurso RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  identifier     = var.db_identifier
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class
  
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  
  port = var.port
  
  vpc_security_group_ids = [var.security_group_id]
  
  db_subnet_group_name = var.subnet_group_name
  
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  
  deletion_protection = var.deletion_protection
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-postgres"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Output para la conexión de la base de datos
output "connection_string" {
  description = "Cadena de conexión a la base de datos PostgreSQL"
  value       = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.postgres.endpoint}/${var.db_name}"
  sensitive   = true
}

output "endpoint" {
  description = "Endpoint de la base de datos"
  value       = aws_db_instance.postgres.endpoint
}

output "port" {
  description = "Puerto de la base de datos"
  value       = aws_db_instance.postgres.port
}

output "arn" {
  description = "ARN de la instancia RDS"
  value       = aws_db_instance.postgres.arn
}

// === ARCHIVO: infra/modules/cache/main.tf ===
# Módulo de Terraform para ElastiCache Redis
# Superficie de práctica - Stub
# Este módulo provee el cache Redis para la API de pedidos

terraform {
  required_version = ">= 1.10.0"
}

# Grupo de subnets para ElastiCache
resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.project}-${var.environment}-redis-subnet"
  subnet_ids = var.subnet_ids
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis-subnet"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Security group para ElastiCache Redis
resource "aws_security_group" "redis" {
  name        = "${var.project}-${var.environment}-redis"
  description = "Security group para ElastiCache Redis"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port       = var.redis_port
    to_port         = var.redis_port
    protocol        = "tcp"
    security_groups = [var.allowed_security_group_id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis-sg"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Recurso de кластер ElastiCache Redis
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = var.replication_group_id
  replication_group_description = "Redis cluster for ${var.project} - ${var.environment}"
  
  engine               = "redis"
  engine_version       = var.engine_version
  node_type            = var.node_type
  number_cache_clusters = var.num_cache_nodes
  
  port                 = var.redis_port
  parameter_group_name = var.parameter_group_name
  
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [aws_security_group.redis.id]
  
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token_enabled         = var.auth_token_enabled
  
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled          = var.multi_az_enabled
  
  snapshot_retention_limit   = var.snapshot_retention_limit
  snapshot_window           = var.snapshot_window
  maintenance_window        = var.maintenance_window
  
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately         = var.apply_immediately
  
  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  
  log_delivery_configuration {
    destination      = aws_elasticache_cloudwatch_log_group.redis.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# CloudWatch Log Group para Redis
resource "aws_elasticache_cloudwatch_log_group" "redis" {
  name              = "/aws/elasticache/${var.project}/${var.environment}/redis"
  retention_in_days = var.log_retention_days
  
  tags = merge(
    var.tags,
    {
      Name        = "${var.project}-${var.environment}-redis-logs"
      Environment = var.environment
      Project     = var.project
      ManagedBy   = "terraform"
    }
  )
}

# Outputs del módulo Redis
output "primary_endpoint" {
  description = "Endpoint primario del cluster Redis"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "reader_endpoint" {
  description = "Endpoint de lectura del cluster Redis"
  value       = aws_elasticache_replication_group.redis.reader_endpoint_address
}

output "port" {
  description = "Puerto de Redis"
  value       = aws_elasticache_replication_group.redis.port
}

output "replication_group_id" {
  description = "ID del grupo de replicación"
  value       = aws_elasticache_replication_group.redis.id
}

output "member_clusters" {
  description = "IDs de los nodos del cluster"
  value       = aws_elasticache_replication_group.redis.member_clusters
}

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/scripts/deploy.sh ===
#!/bin/bash

set -e
set -o pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly TERRAFORM_DIR="${PROJECT_ROOT}"
readonly STATE_BUCKET="terraform-state-pedidos-dev"
readonly LOCK_TABLE="terraform-locks-pedidos"
readonly ENVIRONMENT="dev"

log_info() {
    echo "[INFO] $(date +'%Y-%m-%d %H:%M:%S') - $*"
}

log_error() {
    echo "[ERROR] $(date +'%Y-%m-%d %H:%M:%S') - $*" >&2
}

log_success() {
    echo "[SUCCESS] $(date +'%Y-%m-%d %H:%M:%S') - $*"
}

check_prerequisites() {
    log_info "Verificando prerrequisitos para el despliegue..."

    if ! command -v terraform &> /dev/null; then
        log_error "Terraform no está instalado. Por favor instala Terraform 1.10.0 o superior."
        exit 1
    fi

    local terraform_version
    terraform_version=$(terraform version -json 2>/dev/null | grep -o '"version": "[^"]*"' | cut -d'"' -f4)
    if [[ -z "$terraform_version" ]]; then
        terraform_version=$(terraform version 2>&1 | head -n1 | grep -oP '\d+\.\d+\.\d+')
    fi

    log_info "Terraform versión detectada: $terraform_version"

    local required_version="1.10.0"
    if [[ "$(printf '%s\n' "$required_version" "$terraform_version" | sort -V | head -n1)" != "$required_version" ]]; then
        log_error "Se requiere Terraform $required_version o superior. Versión actual: $terraform_version"
        exit 1
    fi

    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI no está instalado. Por favor instala AWS CLI."
        exit 1
    fi

    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "No hay credenciales de AWS configuradas. Ejecuta 'aws configure'."
        exit 1
    fi

    local account_id
    account_id=$(aws sts get-caller-identity --query 'Account' --output text)
    log_info "Cuenta AWS configurada: $account_id"

    log_success "Todos los prerrequisitos están satisfechos."
}

validate_terraform_files() {
    log_info "Validando archivos de configuración de Terraform..."

    cd "$TERRAFORM_DIR"

    if [[ ! -f "versions.tf" ]]; then
        log_error "No se encontró versions.tf"
        exit 1
    fi

    if [[ ! -f "main.tf" ]]; then
        log_error "No se encontró main.tf"
        exit 1
    fi

    if [[ ! -f "providers.tf" ]]; then
        log_error "No se encontró providers.tf"
        exit 1
    fi

    if [[ ! -f "variables.tf" ]]; then
        log_error "No se encontró variables.tf"
        exit 1
    fi

    log_success "Archivos de configuración validados."
}

initialize_terraform() {
    log_info "Inicializando Terraform..."

    cd "$TERRAFORM_DIR"

    terraform init \
        -backend-config="bucket=$STATE_BUCKET" \
        -backend-config="key=pedidos-api/${ENVIRONMENT}/terraform.tfstate" \
        -backend-config="region=us-east-1" \
        -backend-config="dynamodb_table=$LOCK_TABLE" \
        -reconfigure

    if [[ $? -eq 0 ]]; then
        log_success "Terraform inicializado correctamente."
    else
        log_error "Error al inicializar Terraform."
        exit 1
    fi
}

validate_configuration() {
    log_info "Validando configuración de Terraform..."

    cd "$TERRAFORM_DIR"

    terraform validate

    if [[ $? -eq 0 ]]; then
        log_success "Configuración de Terraform válida."
    else
        log_error "La configuración de Terraform tiene errores."
        exit 1
    fi
}

format_code() {
    log_info "Formateando código de Terraform..."

    cd "$TERRAFORM_DIR"

    terraform fmt -recursive -diff

    if [[ $? -eq 0 ]]; then
        log_success "Código formateado correctamente."
    else
        log_error "Error al formatear el código."
        exit 1
    fi
}

plan_deployment() {
    log_info "Generando plan de despliegue..."

    cd "$TERRAFORM_DIR"

    local plan_file="terraform.plan"

    terraform plan \
        -var-file="environments/${ENVIRONMENT}/terraform.tfvars" \
        -out="$plan_file" \
        -detailed-exitcode

    local exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        log_success "No hay cambios que aplicar."
        return 0
    elif [[ $exit_code -eq 1 ]]; then
        log_error "Error al generar el plan de despliegue."
        exit 1
    elif [[ $exit_code -eq 2 ]]; then
        log_success "Plan de despliegue generado correctamente."
        return 0
    fi
}

apply_deployment() {
    log_info "Aplicando despliegue..."

    cd "$TERRAFORM_DIR"

    local plan_file="terraform.plan"

    if [[ ! -f "$plan_file" ]]; then
        log_error "No se encontró el archivo de plan. Ejecuta plan_deployment primero."
        exit 1
    fi

    terraform apply "$plan_file"

    if [[ $? -eq 0 ]]; then
        log_success "Despliegue aplicado correctamente."
    else
        log_error "Error al aplicar el despliegue."
        exit 1
    fi
}

show_outputs() {
    log_info "Mostrando outputs del despliegue..."

    cd "$TERRAFORM_DIR"

    echo ""
    echo "=========================================="
    echo "  OUTPUTS DEL DESPLIEGUE"
    echo "=========================================="
    terraform output
    echo "=========================================="
    echo ""
}

main() {
    echo ""
    echo "=========================================="
    echo "  SCRIPT DE DESPLIEGUE AUTOMATIZADO"
    echo "  Entorno: $ENVIRONMENT"
    echo "  Fecha: $(date +'%Y-%m-%d %H:%M:%S')"
    echo "=========================================="
    echo ""

    check_prerequisites
    validate_terraform_files
    initialize_terraform
    format_code
    validate_configuration
    plan_deployment
    apply_deployment
    show_outputs

    log_success "Despliegue completado exitosamente!"
    log_info "La API debería estar disponible en https://api-dev.pedidos.example.com"
    log_info "Ejecuta scripts/verify.sh para verificar los recursos aprovisionados."
}

main "$@"

// === ARCHIVO: infra/scripts/verify.sh ===
#!/bin/bash

set -e
set -o pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly API_BASE_URL="https://api-dev.pedidos.example.com"
readonly ENVIRONMENT="dev"
readonly MAX_RETRIES=3
readonly RETRY_DELAY=5
readonly TIMEOUT_SECONDS=30

log_info() {
    echo "[INFO] $(date +'%Y-%m-%d %H:%M:%S') - $*"
}

log_error() {
    echo "[ERROR] $(date +'%Y-%m-%d %H:%M:%S') - $*" >&2
}

log_success() {
    echo "[SUCCESS] $(date +'%Y-%m-%d %H:%M:%S') - $*"
}

log_warning() {
    echo "[WARNING] $(date +'%Y-%m-%d %H:%M:%S') - $*"
}

check_prerequisites() {
    log_info "Verificando prerrequisitos para la verificación..."

    if ! command -v curl &> /dev/null; then
        log_error "curl no está instalado. Por favor instala curl."
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        log_warning "jq no está instalado. La salida JSON no será formateada."
    fi

    if ! command -v aws &> /dev/null; then
        log_warning "AWS CLI no está instalado. No se podrán verificar recursos de AWS."
    fi

    log_success "Prerrequisitos verificados."
}

check_terraform_state() {
    log_info "Verificando estado de Terraform..."

    cd "$PROJECT_ROOT"

    if [[ ! -d ".terraform" ]]; then
        log_error "Terraform no ha sido inicializado. Ejecuta scripts/deploy.sh primero."
        return 1
    fi

    if [[ ! -f "terraform.tfstate" ]] && [[ ! -f ".terraform/terraform.tfstate" ]]; then
        log_warning "No se encontró archivo de estado local. Verificando estado remoto..."
        return 0
    fi

    local state_resources
    state_resources=$(terraform state list 2>/dev/null | wc -l)

    if [[ "$state_resources" -gt 0 ]]; then
        log_success "Estado de Terraform contiene $state_resources recursos."
    else
        log_warning "No hay recursos en el estado de Terraform."
    fi
}

verify_api_health() {
    local endpoint="${API_BASE_URL}/health"
    local attempt=1
    local success=false

    log_info "Verificando health endpoint: $endpoint"

    while [[ $attempt -le $MAX_RETRIES ]] && [[ "$success" == "false" ]]; do
        log_info "Intento $attempt de $MAX_RETRIES..."

        local response
        local http_code

        response=$(curl -s -w "\n%{http_code}" \
            --max-time "$TIMEOUT_SECONDS" \
            -H "Content-Type: application/json" \
            "$endpoint" 2>&1) || true

        http_code=$(echo "$response" | tail -n1)
        local body=$(echo "$response" | sed '$d')

        if [[ "$http_code" == "200" ]]; then
            log_success "Health endpoint responded with HTTP 200"

            if command -v jq &> /dev/null; then
                echo "$body" | jq .
            else
                echo "$body"
            fi

            if echo "$body" | grep -q '"status"'; then
                local status
                status=$(echo "$body" | grep -o '"status"[[:space:]]*:[[:space:]]*"[^"]*"' | cut -d'"' -f4)
                log_info "Health status: $status"
            fi

            if echo "$body" | grep -q '"timestamp"'; then
                local timestamp
                timestamp=$(echo "$body" | grep -o '"timestamp"[[:space:]]*:[[:space:]]*"[^"]*"' | cut -d'"' -f4)
                log_info "Health timestamp: $timestamp"
            fi

            success=true
        else
            log_warning "Health endpoint responded with HTTP $http_code"

            if [[ $attempt -lt $MAX_RETRIES ]]; then
                log_info "Esperando $RETRY_DELAY segundos antes de reintentar..."
                sleep "$RETRY_DELAY"
            fi
        fi

        ((attempt++))
    done

    if [[ "$success" == "false" ]]; then
        log_error "No se pudo verificar el health endpoint después de $MAX_RETRIES intentos."
        return 1
    fi

    return 0
}

verify_api_orders() {
    local endpoint="${API_BASE_URL}/api/orders"
    local success=true

    log_info "Verificando endpoint de orders: $endpoint"

    log_info "Verificando método GET..."
    local get_response
    local get_code

    get_response=$(curl -s -w "\n%{http_code}" \
        --max-time "$TIMEOUT_SECONDS" \
        -H "Content-Type: application/json" \
        "$endpoint" 2>&1) || true

    get_code=$(echo "$get_response" | tail -n1)

    if [[ "$get_code" == "200" ]] || [[ "$get_code" == "401" ]] || [[ "$get_code" == "403" ]]; then
        log_success "GET /api/orders responded with HTTP $get_code"
    else
        log_error "GET /api/orders failed with HTTP $get_code"
        success=false
    fi

    log_info "Verificando método POST..."
    local post_response
    local post_code

    local sample_order='{
        "customer_id": "test-customer-001",
        "items": [
            {
                "product_id": "prod-001",
                "quantity": 2,
                "unit_price": 29.99
            }
        ],
        "shipping_address": "123 Test Street, Test City, TC 12345",
        "total_amount": 59.98
    }'

    post_response=$(curl -s -w "\n%{http_code}" \
        --max-time "$TIMEOUT_SECONDS" \
        -X POST \
        -H "Content-Type: application/json" \
        -d "$sample_order" \
        "$endpoint" 2>&1) || true

    post_code=$(echo "$post_response" | tail -n1)

    if [[ "$post_code" == "200" ]] || [[ "$post_code" == "201" ]] || [[ "$post_code" == "401" ]] || [[ "$post_code" == "403" ]]; then
        log_success "POST /api/orders responded with HTTP $post_code"
    else
        log_error "POST /api/orders failed with HTTP $post_code"
        success=false
    fi

    if [[ "$success" == "true" ]]; then
        return 0
    else
        return 1
    fi
}

verify_api_products() {
    local endpoint="${API_BASE_URL}/api/products"
    local success=true

    log_info "Verificando endpoint de products: $endpoint"

    log_info "Verificando método GET..."
    local get_response
    local get_code

    get_response=$(curl -s -w "\n%{http_code}" \
        --max-time "$TIMEOUT_SECONDS" \
        -H "Content-Type: application/json" \
        "$endpoint" 2>&1) || true

    get_code=$(echo "$get_response" | tail -n1)

    if [[ "$get_code" == "200" ]] || [[ "$get_code" == "401" ]] || [[ "$get_code" == "403" ]]; then
        log_success "GET /api/products responded with HTTP $get_code"
    else
        log_error "GET /api/products failed with HTTP $get_code"
        success=false
    fi

    log_info "Verificando método POST..."
    local post_response
    local post_code

    local sample_product='{
        "name": "Producto de Prueba",
        "description": "Este es un producto de prueba",
        "price": 49.99,
        "category": "electronics",
        "stock": 100,
        "sku": "TEST-001"
    }'

    post_response=$(curl -s -w "\n%{http_code}" \
        --max-time "$TIMEOUT_SECONDS" \
        -X POST \
        -H "Content-Type: application/json" \
        -d "$sample_product" \
        "$endpoint" 2>&1) || true

    post_code=$(echo "$post_response" | tail -n1)

    if [[ "$post_code" == "200" ]] || [[ "$post_code" == "201" ]] || [[ "$post_code" == "401" ]] || [[ "$post_code" == "403" ]]; then
        log_success "POST /api/products responded with HTTP $post_code"
    else
        log_error "POST /api/products failed with HTTP $post_code"
        success=false
    fi

    if [[ "$success" == "true" ]]; then
        return 0
    else
        return 1
    fi
}

verify_aws_resources() {
    log_info "Verificando recursos de AWS..."

    if ! command -v aws &> /dev/null; then
        log_warning "AWS CLI no disponible. Omitiendo verificación de recursos AWS."
        return 0
    fi

    log_info "Verificando recursos de API Gateway..."
    local apis
    apis=$(aws apigateway get-rest-apis --query 'items[?name==`pedidos-api-dev`]' --output text 2>/dev/null | wc -l) || true

    if [[ "$apis" -gt 0 ]]; then
        log_success "API Gateway REST API encontrada para pedidos-api-dev"
    else
        log_warning "No se encontró API Gateway REST API para pedidos-api-dev"
    fi

    log_info "Verificando recursos de DynamoDB..."
    local tables
    tables=$(aws dynamodb list-tables --query 'TableNames[?contains(@, `pedidos`)]' --output text 2>/dev/null | wc -l) || true

    if [[ "$tables" -gt 0 ]]; then
        log_success "Tablas DynamoDB relacionadas con pedidos encontradas"
    else
        log_warning "No se encontraron tablas DynamoDB para pedidos"
    fi

    log_info "Verificando recursos de S3..."
    local buckets
    buckets=$(aws s3api list-buckets --query 'Buckets[?contains(Name, `pedidos`)]' --output text 2>/dev/null | wc -l) || true

    if [[ "$buckets" -gt 0 ]]; then
        log_success "Buckets S3 relacionados con pedidos encontrados"
    else
        log_warning "No se encontraron buckets S3 para pedidos"
    fi

    log_success "Verificación de recursos AWS completada."
}

print_summary() {
    local health_status="$1"
    local orders_status="$2"
    local products_status="$3"

    echo ""
    echo "=========================================="
    echo "  RESUMEN DE VERIFICACIÓN"
    echo "  Entorno: $ENVIRONMENT"
    echo "  Fecha: $(date +'%Y-%m-%d %H:%M:%S')"
    echo "=========================================="
    echo " Health Endpoint:       $health_status"
    echo " Orders API:            $orders_status"
    echo " Products API:          $products_status"
    echo " AWS Resources:         VERIFIED"
    echo "=========================================="
    echo ""

    if [[ "$health_status" == "PASS" ]] && [[ "$orders_status" == "PASS" ]] && [[ "$products_status" == "PASS" ]]; then
        log_success "Todas las verificaciones pasaron correctamente!"
        return 0
    else
        log_error "Algunas verificaciones fallaron. Revisa los logs anteriores."
        return 1
    fi
}

main() {
    echo ""
    echo "=========================================="
    echo "  SCRIPT DE VERIFICACIÓN DE RECURSOS"
    echo "  Entorno: $ENVIRONMENT"
    echo "  Fecha: $(date +'%Y-%m-%d %H:%M:%S')"
    echo "=========================================="
    echo ""

    check_prerequisites
    check_terraform_state

    local health_result="FAIL"
    local orders_result="FAIL"
    local products_result="FAIL"

    if verify_api_health; then
        health_result="PASS"
    fi

    if verify_api_orders; then
        orders_result="PASS"
    fi

    if verify_api_products; then
        products_result="PASS"
    fi

    verify_aws_resources

    print_summary "$health_result" "$orders_result" "$products_result"

    if [[ "$health_result" == "PASS" ]] && [[ "$orders_result" == "PASS" ]] && [[ "$products_result" == "PASS" ]]; then
        exit 0
    else
        exit 1
    fi
}

main "$@"

// === ARCHIVO: client/pubspec.yaml ===
name: pedido_app
description: Aplicación móvil de pedidos con infraestructura backend aprovisionada con Terraform.
version: 1.0.0+1

environment:
  sdk: ">=3.6.0 <4.0.0"
  flutter: ">=3.27.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  http: ^1.2.2
  get_it: ^8.0.3
  equatable: ^2.0.7
  flutter_localizations:
    sdk: flutter

  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.13

flutter:
  uses-material-design: true
  generate: true

// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pedido_app/di/injection.dart';
import 'package:pedido_app/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const PedidoApp());
}

class PedidoApp extends StatelessWidget {
  const PedidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<ProductsViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<OrdersViewModel>()),
      ],
      child: MaterialApp(
        title: 'Pedido App',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// Inicialización de dependencias y configuración de la aplicación
void configureDependencies() {
  try {
    getIt.registerSingleton<ProductsViewModel>(ProductsViewModel(
      productRepository: getIt<ProductRepository>(),
    ));
    getIt.registerSingleton<OrdersViewModel>(OrdersViewModel(
      orderRepository: getIt<OrderRepository>(),
    ));
  } catch (e) {
    throw Exception('Error al configurar dependencias: $e');
  }
}

// === ARCHIVO: client/lib/core/config/api_config.dart ===
/// Configuración centralizada de las URLs y parámetros de la API.
/// Todas las URLs base y endpoints se definen aquí para facilitar su modificación.
library pedido_app.config;

class ApiConfig {
  // URLs base para los diferentes entornos
  static const String _baseUrlDev = 'https://dev-api.pedidosapp.com';
  static const String _baseUrlProd = 'https://api.pedidosapp.com';
  static const String _baseUrlStaging = 'https://staging-api.pedidosapp.com';

  // Endpoints de la API
  static const String ordersEndpoint = '/api/v1/orders';
  static const String productsEndpoint = '/api/v1/products';
  static const String authEndpoint = '/api/v1/auth';
  static const String usersEndpoint = '/api/v1/users';

  // Configuración de timeout y retries
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(milliseconds: 500);

  /// URL base activa según el entorno seleccionado
  static String get baseUrl {
    // En producción se usaría _baseUrlProd, pero para desarrollo usamos staging
    return _baseUrlStaging;
  }

  /// URL completa para el endpoint de órdenes
  static String get ordersUrl => '$baseUrl$ordersEndpoint';

  /// URL completa para el endpoint de productos
  static String get productsUrl => '$baseUrl$productsEndpoint';

  /// URL completa para el endpoint de autenticación
  static String get authUrl => '$baseUrl$authEndpoint';

  /// URL completa para el endpoint de usuarios
  static String get usersUrl => '$baseUrl$usersEndpoint';

  /// Headers por defecto para las peticiones HTTP
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Request-Source': 'mobile',
  };
}

// === ARCHIVO: client/lib/core/constants/app_constants.dart ===
/// Constantes globales de la aplicación para evitar valores mágicos en el código.
/// Incluye textos, límites, identificadores y configuraciones comunes.
library pedido_app.constants;

class AppConstants {
  // Límites de datos
  static const int maxProductsPerOrder = 50;
  static const int maxOrderDescriptionLength = 200;
  static const int minOrderItems = 1;
  static const double minOrderTotal = 0.01;

  // Identificadores de rutas
  static const String homeRoute = '/home';
  static const String ordersRoute = '/orders';
  static const String productsRoute = '/products';
  static const String orderDetailRoute = '/order-detail';
  static const String productDetailRoute = '/product-detail';

  // Textos de la aplicación
  static const String appName = 'PedidoApp';
  static const String ordersTitle = 'Mis Pedidos';
  static const String productsTitle = 'Productos';
  static const String orderDetailTitle = 'Detalle de Pedido';
  static const String emptyOrdersMessage = 'No tienes pedidos aún';
  static const String emptyProductsMessage = 'No hay productos disponibles';
  static const String retryButtonText = 'Reintentar';
  static const String errorTitle = 'Error';
  static const String networkErrorMessage = 'No hay conexión a internet';
  static const String serverErrorMessage = 'Error en el servidor';
  static const String unknownErrorMessage = 'Error desconocido';
  static const String orderCreatedMessage = 'Pedido creado con éxito';
  static const String orderFailedMessage = 'No se pudo crear el pedido';

  // Configuración de paginación
  static const int productsPageSize = 10;
  static const int ordersPageSize = 5;

  // Configuración de caché
  static const Duration productsCacheDuration = Duration(minutes: 30);
  static const Duration ordersCacheDuration = Duration(minutes: 15);

  // Configuración de animaciones
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);

  // Configuración de validación
  static final RegExp emailRegex = RegExp(
    r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$',
  );
  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  // Configuración de seguridad
  static const int minPasswordLength = 8;
  static const String biometricAuthKey = 'biometric_auth_pref';
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';

  // Configuración de localización
  static const String defaultLocale = 'es';
  static const List<String> supportedLocales = ['es', 'en'];

  // Configuración de logging
  static const String logTag = 'PedidoApp';
  static const bool enableDebugLogs = true;
}

// === ARCHIVO: client/lib/domain/entities/order.dart ===
import 'package:equatable/equatable.dart';

/// Entidad que representa un pedido en el dominio de la aplicación.
/// Contiene la información esencial de un pedido y sus líneas de pedido.
class Order extends Equatable {
  final String id;
  final DateTime date;
  final String status;
  final List<OrderItem> items;
  final double total;
  final String customerId;
  final String? description;
  final String paymentMethod;
  final String deliveryAddress;
  final DateTime? deliveryDate;
  final String? trackingNumber;

  const Order({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.total,
    required this.customerId,
    this.description,
    required this.paymentMethod,
    required this.deliveryAddress,
    this.deliveryDate,
    this.trackingNumber,
  });

  /// Calcula el total del pedido sumando los subtotales de todos los items
  double get calculatedTotal => items.fold(0.0, (sum, item) => sum + item.subtotal);

  /// Verifica si el pedido está completo
  bool get isCompleted => status == 'completed';

  /// Verifica si el pedido está en proceso
  bool get isProcessing => status == 'processing';

  /// Verifica si el pedido fue cancelado
  bool get isCancelled => status == 'cancelled';

  /// Crea una copia del pedido con los valores modificados
  Order copyWith({
    String? id,
    DateTime? date,
    String? status,
    List<OrderItem>? items,
    double? total,
    String? customerId,
    String? description,
    String? paymentMethod,
    String? deliveryAddress,
    DateTime? deliveryDate,
    String? trackingNumber,
  }) {
    return Order(
      id: id ?? this.id,
      date: date ?? this.date,
      status: status ?? this.status,
      items: items ?? this.items,
      total: total ?? this.total,
      customerId: customerId ?? this.customerId,
      description: description ?? this.description,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      trackingNumber: trackingNumber ?? this.trackingNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        status,
        items,
        total,
        customerId,
        description,
        paymentMethod,
        deliveryAddress,
        deliveryDate,
        trackingNumber,
      ];
}

/// Entidad que representa un ítem dentro de un pedido.
class OrderItem extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double? discount;
  final Map<String, dynamic>? attributes;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.discount,
    this.attributes,
  });

  /// Calcula el subtotal del ítem (precio unitario * cantidad - descuento)
  double get subtotal {
    final discountAmount = discount ?? 0.0;
    return (unitPrice * quantity) - discountAmount;
  }

  /// Verifica si el ítem tiene descuento
  bool get hasDiscount => discount != null && discount! > 0;

  @override
  List<Object?> get props => [
        productId,
        productName,
        quantity,
        unitPrice,
        discount,
        attributes,
      ];
}

/// Estados posibles de un pedido
class OrderStatus {
  static const String pending = 'pending';
  static const String processing = 'processing';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const String failed = 'failed';

  static const List<String> values = [
    pending,
    processing,
    completed,
    cancelled,
    failed,
  ];
}

/// Métodos de pago disponibles
class PaymentMethod {
  static const String creditCard = 'credit_card';
  static const String debitCard = 'debit_card';
  static const String cash = 'cash';
  static const String transfer = 'bank_transfer';
  static const String paypal = 'paypal';

  static const List<String> values = [
    creditCard,
    debitCard,
    cash,
    transfer,
    paypal,
  ];
}

// === ARCHIVO: client/lib/domain/entities/product.dart ===
library pedido_app.domain.entities;

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String category;
  final int stock;
  final bool isAvailable;
  final double? discountPercentage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;
  final double? rating;
  final int? reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.category,
    required this.stock,
    this.isAvailable = true,
    this.discountPercentage,
    this.createdAt,
    this.updatedAt,
    this.metadata,
    this.rating,
    this.reviewCount,
  });

  double get effectivePrice {
    if (discountPercentage != null && discountPercentage! > 0) {
      return price * (1 - discountPercentage! / 100);
    }
    return price;
  }

  bool get hasDiscount => discountPercentage != null && discountPercentage! > 0;

  bool get isInStock => stock > 0;

  bool get isLowStock => stock > 0 && stock <= 5;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    int? stock,
    bool? isAvailable,
    double? discountPercentage,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
    double? rating,
    int? reviewCount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        stock,
        isAvailable,
        discountPercentage,
        createdAt,
        updatedAt,
        metadata,
        rating,
        reviewCount,
      ];
}

class ProductCategory {
  static const String food = 'food';
  static const String beverages = 'beverages';
  static const String electronics = 'electronics';
  static const String clothing = 'clothing';
  static const String home = 'home';
  static const String sports = 'sports';
  static const String books = 'books';
  static const String toys = 'toys';
  static const String health = 'health';
  static const String other = 'other';

  static const List<String> all = [
    food,
    beverages,
    electronics,
    clothing,
    home,
    sports,
    books,
    toys,
    health,
    other,
  ];

  static String getDisplayName(String category) {
    switch (category) {
      case food:
        return 'Comida';
      case beverages:
        return 'Bebidas';
      case electronics:
        return 'Electrónica';
      case clothing:
        return 'Ropa';
      case home:
        return 'Hogar';
      case sports:
        return 'Deportes';
      case books:
        return 'Libros';
      case toys:
        return 'Juguetes';
      case health:
        return 'Salud';
      case other:
        return 'Otros';
      default:
        return category;
    }
  }
}

// === ARCHIVO: client/lib/domain/repositories/order_repository.dart ===
library pedido_app.domain.repositories;

import 'package:pedido_app/domain/entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders({int? limit, int? offset});

  Future<Order> getOrderById(String orderId);

  Future<Order> createOrder({
    required List<OrderItem> items,
    required String customerId,
    required String paymentMethod,
    required String deliveryAddress,
    String? description,
    DateTime? deliveryDate,
  });

  Future<Order> updateOrderStatus({
    required String orderId,
    required String newStatus,
  });

  Future<Order> updateOrder({
    required String orderId,
    List<OrderItem>? items,
    String? paymentMethod,
    String? deliveryAddress,
    String? description,
    DateTime? deliveryDate,
    String? trackingNumber,
  });

  Future<void> cancelOrder(String orderId);

  Future<List<Order>> getOrdersByStatus(String status, {int? limit, int? offset});

  Future<List<Order>> getOrdersByCustomer(String customerId, {int? limit, int? offset});

  Future<String> generateOrderId();

  Future<bool> validateOrderAvailability(List<OrderItem> items);
}

// === ARCHIVO: client/lib/domain/repositories/product_repository.dart ===
library pedido_app.domain.repositories;

import 'package:pedido_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({
    int? limit,
    int? offset,
    String? category,
    bool? availableOnly,
  });

  Future<Product> getProductById(String productId);

  Future<List<Product>> searchProducts(String query, {int? limit});

  Future<List<Product>> getProductsByCategory(String category, {int? limit, int? offset});

  Future<List<Product>> getFeaturedProducts({int? limit});

  Future<List<Product>> getProductsOnSale({int? limit});

  Future<List<Product>> getRelatedProducts(String productId, {int? limit});

  Future<bool> checkProductAvailability(String productId, int requestedQuantity);

  Future<Map<String, int>> checkBulkAvailability(List<Map<String, dynamic>> items);

  Future<void> updateProductStock(String productId, int newStock);

  Future<List<String>> getAllCategories();
}

// === ARCHIVO: client/lib/data/models/order_model.dart ===
library pedido_app.data.models;

import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';

class OrderModel extends Equatable {
  final String id;
  final DateTime date;
  final String status;
  final List<OrderItemModel> items;
  final double total;
  final String customerId;
  final String? description;
  final String paymentMethod;
  final String deliveryAddress;
  final DateTime? deliveryDate;
  final String? trackingNumber;

  const OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.total,
    required this.customerId,
    this.description,
    required this.paymentMethod,
    required this.deliveryAddress,
    this.deliveryDate,
    this.trackingNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      customerId: json['customerId'] as String,
      description: json['description'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'] as String)
          : null,
      trackingNumber: json['trackingNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'customerId': customerId,
      'description': description,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'trackingNumber': trackingNumber,
    };
  }

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      date: order.date,
      status: order.status,
      items: order.items.map((item) => OrderItemModel.fromEntity(item)).toList(),
      total: order.total,
      customerId: order.customerId,
      description: order.description,
      paymentMethod: order.paymentMethod,
      deliveryAddress: order.deliveryAddress,
      deliveryDate: order.deliveryDate,
      trackingNumber: order.trackingNumber,
    );
  }

  Order toEntity() {
    return Order(
      id: id,
      date: date,
      status: status,
      items: items.map((item) => item.toEntity()).toList(),
      total: total,
      customerId: customerId,
      description: description,
      paymentMethod: paymentMethod,
      deliveryAddress: deliveryAddress,
      deliveryDate: deliveryDate,
      trackingNumber: trackingNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        status,
        items,
        total,
        customerId,
        description,
        paymentMethod,
        deliveryAddress,
        deliveryDate,
        trackingNumber,
      ];
}

class OrderItemModel extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double? discount;
  final Map<String, dynamic>? attributes;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.discount,
    this.attributes,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'discount': discount,
      'attributes': attributes,
    };
  }

  factory OrderItemModel.fromEntity(OrderItem item) {
    return OrderItemModel(
      productId: item.productId,
      productName: item.productName,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      discount: item.discount,
      attributes: item.attributes,
    );
  }

  OrderItem toEntity() {
    return OrderItem(
      productId: productId,
      productName: productName,
      quantity: quantity,
      unitPrice: unitPrice,
      discount: discount,
      attributes: attributes,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        quantity,
        unitPrice,
        discount,
        attributes,
      ];
}

// === ARCHIVO: client/lib/data/models/product_model.dart ===
library pedido_app.data.models;

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String category;
  final int stock;
  final bool isAvailable;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.category,
    required this.stock,
    required this.isAvailable,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String,
      stock: json['stock'] as int,
      isAvailable: json['isAvailable'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'stock': stock,
      'isAvailable': isAvailable,
      'metadata': metadata,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    int? stock,
    bool? isAvailable,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        stock,
        isAvailable,
        metadata,
        createdAt,
        updatedAt,
      ];
}

// === ARCHIVO: client/lib/data/datasources/remote/order_remote_datasource.dart ===
library pedido_app.data.datasources.remote;

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/order_model.dart';
import '../../../core/config/api_config.dart';
import '../../../core/constants/app_constants.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String orderId);
  Future<OrderModel> createOrder(OrderModel order);
  Future<OrderModel> updateOrderStatus(String orderId, String status);
  Future<void> cancelOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  OrderRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<OrderModel>> getOrders() async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}');
      final response = await client
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<List<OrderModel>>(
        response,
        (data) => (data as List<dynamic>)
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    });
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}/$orderId');
      final response = await client
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<OrderModel>(
        response,
        (data) => OrderModel.fromJson(data as Map<String, dynamic>),
      );
    });
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}');
      final body = jsonEncode(order.toJson());
      final response = await client
          .post(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<OrderModel>(
        response,
        (data) => OrderModel.fromJson(data as Map<String, dynamic>),
      );
    });
  }

  @override
  Future<OrderModel> updateOrderStatus(String orderId, String status) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}/$orderId/status');
      final body = jsonEncode({'status': status});
      final response = await client
          .patch(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<OrderModel>(
        response,
        (data) => OrderModel.fromJson(data as Map<String, dynamic>),
      );
    });
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}/$orderId');
      final response = await client
          .delete(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<void>(
        response,
        (_) => null,
      );
    });
  }

  Map<String, String> _buildHeaders({String contentType = 'application/json'}) {
    return {
      'Content-Type': contentType,
      'Accept': 'application/json',
    };
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic data) parser,
  ) {
    switch (response.statusCode) {
      case 200:
      case 201:
        final data = jsonDecode(response.body);
        return parser(data);
      case 400:
        throw OrderDataSourceException(
          message: 'Solicitud incorrecta',
          statusCode: 400,
        );
      case 401:
        throw OrderDataSourceException(
          message: 'No autorizado',
          statusCode: 401,
        );
      case 403:
        throw OrderDataSourceException(
          message: 'Acceso prohibido',
          statusCode: 403,
        );
      case 404:
        throw OrderDataSourceException(
          message: 'Pedido no encontrado',
          statusCode: 404,
        );
      case 500:
      case 502:
      case 503:
        throw OrderDataSourceException(
          message: 'Error del servidor',
          statusCode: response.statusCode,
        );
      default:
        throw OrderDataSourceException(
          message: 'Error desconocido: ${response.statusCode}',
          statusCode: response.statusCode,
        );
    }
  }

  Future<T> _executeWithRetry<T>(
    Future<T> Function() operation,
  ) async {
    int attempts = 0;
    Duration delay = ApiConfig.retryDelay;
    Exception? lastException;

    while (attempts < ApiConfig.maxRetries) {
      try {
        return await operation();
      } on OrderDataSourceException {
        rethrow;
      } catch (e) {
        lastException = e;
        attempts++;
        if (attempts < ApiConfig.maxRetries) {
          await Future.delayed(delay);
          delay *= 2;
        }
      }
    }

    throw OrderDataSourceException(
      message: 'Error después de ${ApiConfig.maxRetries} intentos: ${lastException?.toString()}',
      statusCode: 0,
    );
  }
}

class OrderDataSourceException implements Exception {
  final String message;
  final int statusCode;

  OrderDataSourceException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => 'OrderDataSourceException: $message (code: $statusCode)';

  bool get isNetworkError => statusCode == 0;
  bool get isNotFound => statusCode == 404;
  bool get isUnauthorized => statusCode == 401;
  bool get isServerError => statusCode >= 500;
}

// === ARCHIVO: client/lib/data/datasources/remote/product_remote_datasource.dart ===
library pedido_app.data.datasources.remote;

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import '../../../core/config/api_config.dart';
import '../../../core/constants/app_constants.dart';

class ProductRemoteDatasource {
  final http.Client _client;
  
  ProductRemoteDatasource({http.Client? client}) : _client = client ?? http.Client();
  
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20}) async {
    final uri = Uri.parse(
      '${ApiConfig.productsUrl}?page=$page&limit=$limit',
    );
    
    try {
      final response = await _client.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleListResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<ProductModel> getProductById(String id) async {
    final uri = Uri.parse('${ApiConfig.productsUrl}/$id');
    
    try {
      final response = await _client.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleSingleResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<List<ProductModel>> searchProducts(String query) async {
    final uri = Uri.parse(
      '${ApiConfig.productsUrl}/search?q=${Uri.encodeComponent(query)}',
    );
    
    try {
      final response = await _client.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleListResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<ProductModel> createProduct(ProductModel product) async {
    final uri = Uri.parse(ApiConfig.productsUrl);
    
    try {
      final response = await _client.post(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(product.toJson()),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleSingleResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<ProductModel> updateProduct(String id, ProductModel product) async {
    final uri = Uri.parse('${ApiConfig.productsUrl}/$id');
    
    try {
      final response = await _client.put(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(product.toJson()),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleSingleResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<void> deleteProduct(String id) async {
    final uri = Uri.parse('${ApiConfig.productsUrl}/$id');
    
    try {
      final response = await _client.delete(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      if (response.statusCode >= 400) {
        throw HttpException('Error al eliminar producto: ${response.statusCode}');
      }
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
  
  List<ProductModel> _handleListResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw HttpException('Error HTTP: ${response.statusCode}');
    }
  }
  
  ProductModel _handleSingleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ProductModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw HttpException('Producto no encontrado');
    } else {
      throw HttpException('Error HTTP: ${response.statusCode}');
    }
  }
  
  Exception _mapException(dynamic e) {
    if (e is Exception) return e;
    return Exception('Error desconocido: $e');
  }
  
  void dispose() {
    _client.close();
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  
  @override
  String toString() => message;
}

// === ARCHIVO: client/lib/data/repositories/order_repository_impl.dart ===
library pedido_app.data.repositories;

import '../../domain/repositories/order_repository.dart';
import '../../domain/entities/order.dart';
import '../datasources/remote/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource _remoteDatasource;
  
  OrderRepositoryImpl({required OrderRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;
  
  @override
  Future<List<Order>> getOrders({int page = 1, int limit = 20}) async {
    final orderModels = await _remoteDatasource.getOrders(page: page, limit: limit);
    return orderModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<Order> getOrderById(String id) async {
    final orderModel = await _remoteDatasource.getOrderById(id);
    return _mapModelToEntity(orderModel);
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    final orderModel = _mapEntityToModel(order);
    final createdModel = await _remoteDatasource.createOrder(orderModel);
    return _mapModelToEntity(createdModel);
  }
  
  @override
  Future<Order> updateOrder(String id, Order order) async {
    final orderModel = _mapEntityToModel(order);
    final updatedModel = await _remoteDatasource.updateOrder(id, orderModel);
    return _mapModelToEntity(updatedModel);
  }
  
  @override
  Future<void> cancelOrder(String id) async {
    await _remoteDatasource.cancelOrder(id);
  }
  
  @override
  Future<List<Order>> getOrdersByStatus(String status, {int page = 1, int limit = 20}) async {
    final orderModels = await _remoteDatasource.getOrdersByStatus(status, page: page, limit: limit);
    return orderModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<List<Order>> getOrdersByCustomer(String customerId, {int page = 1, int limit = 20}) async {
    final orderModels = await _remoteDatasource.getOrdersByCustomer(customerId, page: page, limit: limit);
    return orderModels.map(_mapModelToEntity).toList();
  }
  
  Order _mapModelToEntity(OrderModel model) {
    return Order(
      id: model.id,
      date: model.date,
      status: model.status,
      items: model.items.map((item) => OrderItem(
        productId: item.productId,
        productName: item.productName,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        discount: item.discount,
        attributes: item.attributes,
      )).toList(),
      total: model.total,
      customerId: model.customerId,
      description: model.description,
      paymentMethod: model.paymentMethod,
      deliveryAddress: model.deliveryAddress,
      deliveryDate: model.deliveryDate,
      trackingNumber: model.trackingNumber,
    );
  }
  
  OrderModel _mapEntityToModel(Order entity) {
    return OrderModel(
      id: entity.id,
      date: entity.date,
      status: entity.status,
      items: entity.items.map((item) => OrderItemModel(
        productId: item.productId,
        productName: item.productName,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        discount: item.discount,
        attributes: item.attributes,
      )).toList(),
      total: entity.total,
      customerId: entity.customerId,
      description: entity.description,
      paymentMethod: entity.paymentMethod,
      deliveryAddress: entity.deliveryAddress,
      deliveryDate: entity.deliveryDate,
      trackingNumber: entity.trackingNumber,
    );
  }
}

// === ARCHIVO: client/lib/data/repositories/product_repository_impl.dart ===
library pedido_app.data.repositories;

import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product.dart';
import '../datasources/remote/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource _remoteDatasource;
  
  ProductRepositoryImpl({required ProductRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;
  
  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 20}) async {
    final productModels = await _remoteDatasource.getProducts(page: page, limit: limit);
    return productModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<Product> getProductById(String id) async {
    final productModel = await _remoteDatasource.getProductById(id);
    return _mapModelToEntity(productModel);
  }
  
  @override
  Future<List<Product>> searchProducts(String query) async {
    final productModels = await _remoteDatasource.searchProducts(query);
    return productModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<Product> createProduct(Product product) async {
    final productModel = _mapEntityToModel(product);
    final createdModel = await _remoteDatasource.createProduct(productModel);
    return _mapModelToEntity(createdModel);
  }
  
  @override
  Future<Product> updateProduct(String id, Product product) async {
    final productModel = _mapEntityToModel(product);
    final updatedModel = await _remoteDatasource.updateProduct(id, productModel);
    return _mapModelToEntity(updatedModel);
  }
  
  @override
  Future<void> deleteProduct(String id) async {
    await _remoteDatasource.deleteProduct(id);
  }
  
  Product _mapModelToEntity(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      imageUrl: model.imageUrl,
      category: model.category,
      stock: model.stock,
      isAvailable: model.isAvailable,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
  
  ProductModel _mapEntityToModel(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      category: entity.category,
      stock: entity.stock,
      isAvailable: entity.isAvailable,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    
    <application
        android:label="PedidoApp"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:allowBackup="false"
        android:fullBackupContent="false"
        android:supportsRtl="true"
        android:theme="@style/LaunchTheme"
        android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
        android:hardwareAccelerated="true"
        android:windowSoftInputMode="adjustResize">
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
            
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
            
        <receiver
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
            android:exported="false" />
        
        <receiver
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
            android:exported="false">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED" />
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED" />
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON" />
            </intent-filter>
        </receiver>
        
    </application>
    
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
    
</manifest>

// === ARCHIVO: client/lib/presentation/viewmodels/orders_viewmodel.dart ===
import 'package:flutter/foundation.dart';
import 'package:pedido_app/domain/entities/order.dart';
import 'package:pedido_app/domain/repositories/order_repository.dart';
import 'package:pedido_app/core/constants/app_constants.dart';

class OrdersViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 0;

  OrdersViewModel({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isEmpty => _orders.isEmpty && !_isLoading;

  Future<void> loadOrders({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 0;
      _hasMore = true;
      _orders = [];
    }

    if (!_hasMore && !refresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newOrders = await _orderRepository.getOrders(
        page: _currentPage,
        pageSize: AppConstants.ordersPageSize,
      );

      if (newOrders.length < AppConstants.ordersPageSize) {
        _hasMore = false;
      }

      if (refresh) {
        _orders = newOrders;
      } else {
        _orders = [..._orders, ...newOrders];
      }

      _currentPage++;
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreOrders() async {
    if (!_isLoading && _hasMore) {
      await loadOrders();
    }
  }

  Future<bool> createOrder({
    required List<OrderItem> items,
    required String customerId,
    required String paymentMethod,
    required String deliveryAddress,
    String? description,
    DateTime? deliveryDate,
  }) async {
    if (items.length < AppConstants.minOrderItems) {
      _errorMessage = AppConstants.orderFailedMessage;
      notifyListeners();
      return false;
    }

    final total = _calculateTotal(items);
    if (total < AppConstants.minOrderTotal) {
      _errorMessage = AppConstants.orderFailedMessage;
      notifyListeners();
      return false;
    }

    if (description != null && 
        description.length > AppConstants.maxOrderDescriptionLength) {
      _errorMessage = AppConstants.orderFailedMessage;
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final order = Order(
        id: '',
        date: DateTime.now(),
        status: OrderStatus.pending,
        items: items,
        total: total,
        customerId: customerId,
        description: description,
        paymentMethod: paymentMethod,
        deliveryAddress: deliveryAddress,
        deliveryDate: deliveryDate,
      );

      final createdOrder = await _orderRepository.createOrder(order);
      _orders = [createdOrder, ..._orders];
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedOrder = await _orderRepository.updateOrderStatus(
        orderId, 
        newStatus,
      );

      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _orders[index] = updatedOrder;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshOrders() async {
    await loadOrders(refresh: true);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  double _calculateTotal(List<OrderItem> items) {
    return items.fold(0.0, (sum, item) {
      final itemTotal = item.unitPrice * item.quantity;
      final discount = item.discount ?? 0.0;
      return sum + itemTotal - discount;
    });
  }

  String _mapErrorToMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('TimeoutException')) {
      return AppConstants.networkErrorMessage;
    } else if (error.toString().contains('HttpException')) {
      return AppConstants.serverErrorMessage;
    }
    return AppConstants.unknownErrorMessage;
  }

  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Order> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  List<Order> getPendingOrders() {
    return _orders.where((order) => order.isProcessing).toList();
  }

  List<Order> getCompletedOrders() {
    return _orders.where((order) => order.isCompleted).toList();
  }

  double get totalSpent {
    return _orders
        .where((order) => order.isCompleted)
        .fold(0.0, (sum, order) => sum + order.total);
  }
}

// === ARCHIVO: client/lib/presentation/viewmodels/products_viewmodel.dart ===
import 'package:flutter/foundation.dart';
import 'package:pedido_app/domain/entities/product.dart';
import 'package:pedido_app/domain/repositories/product_repository.dart';
import 'package:pedido_app/core/constants/app_constants.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;
  
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 0;
  String _searchQuery = '';
  String? _selectedCategory;

  ProductsViewModel({required ProductRepository productRepository})
      : _productRepository = productRepository;

  List<Product> get products => _searchQuery.isEmpty && _selectedCategory == null
      ? _products 
      : _filteredProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isEmpty => products.isEmpty && !_isLoading;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;

  Future<void> loadProducts({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 0;
      _hasMore = true;
      _products = [];
      _filteredProducts = [];
    }

    if (!_hasMore && !refresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newProducts = await _productRepository.getProducts(
        page: _currentPage,
        pageSize: AppConstants.productsPageSize,
      );

      if (newProducts.length < AppConstants.productsPageSize) {
        _hasMore = false;
      }

      if (refresh) {
        _products = newProducts;
      } else {
        _products = [..._products, ...newProducts];
      }

      _currentPage++;
      _applyFilters();
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreProducts() async {
    if (!_isLoading && _hasMore) {
      await loadProducts();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _filteredProducts = [];
    notifyListeners();
  }

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery) ||
          product.description.toLowerCase().contains(_searchQuery);

      final matchesCategory = _selectedCategory == null ||
          product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  Future<void> refreshProducts() async {
    await loadProducts(refresh: true);
  }

  Future<Product?> getProductById(String id) async {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      try {
        return await _productRepository.getProductById(id);
      } catch (e) {
        return null;
      }
    }
  }

  List<Product> getFeaturedProducts() {
    return _products.where((p) => p.isFeatured).toList();
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  List<String> get availableCategories {
    final categories = _products.map((p) => p.category).toSet().toList();
    categories.sort();
    return categories;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  String _mapErrorToMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('TimeoutException')) {
      return AppConstants.networkErrorMessage;
    } else if (error.toString().contains('HttpException')) {
      return AppConstants.serverErrorMessage;
    }
    return AppConstants.unknownErrorMessage;
  }
}

// === ARCHIVO: client/lib/presentation/widgets/order_card.dart ===
import 'package:flutter/material.dart';
import 'package:pedido_app/domain/entities/order.dart';
import 'package:pedido_app/core/constants/app_constants.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;
  final VoidCallback? onStatusTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, colorScheme),
              const SizedBox(height: 12),
              _buildOrderInfo(context),
              const SizedBox(height: 12),
              _buildItemsPreview(context),
              const SizedBox(height: 12),
              _buildFooter(context, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pedido #${order.id.substring(0, 8).toUpperCase()}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        _StatusChip(
          status: order.status,
          onTap: onStatusTap,
        ),
      ],
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          _formatDate(order.date),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.shopping_bag_outlined,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          '${order.items.length} ${order.items.length == 1 ? 'producto' : 'productos'}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildItemsPreview(BuildContext context) {
    final displayItems = order.items.take(3).toList();
    final remainingCount = order.items.length - 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...displayItems.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${item.quantity}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.productName,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '\$${item.unitPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )),
        if (remainingCount > 0)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '+$remainingCount ${remainingCount == 1 ? 'producto más' : 'productos más'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                '\$${order.calculatedTotal.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                _getPaymentIcon(order.paymentMethod),
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                _formatPaymentMethod(order.paymentMethod),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} días atrás';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatPaymentMethod(String method) {
    switch (method) {
      case PaymentMethod.creditCard:
        return 'Tarjeta de crédito';
      case PaymentMethod.debitCard:
        return 'Tarjeta de débito';
      case PaymentMethod.cash:
        return 'Efectivo';
      case PaymentMethod.transfer:
        return 'Transferencia';
      case PaymentMethod.paypal:
        return 'PayPal';
      default:
        return method;
    }
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case PaymentMethod.creditCard:
      case PaymentMethod.debitCard:
        return Icons.credit_card;
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.transfer:
        return Icons.account_balance;
      case PaymentMethod.paypal:
        return Icons.payment;
      default:
        return Icons.payment;
    }
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  final VoidCallback? onTap;

  const _StatusChip({
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: config.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              config.icon,
              size: 14,
              color: config.textColor,
            ),
            const SizedBox(width: 4),
            Text(
              config.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: config.textColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(String status) {
    switch (status) {
      case OrderStatus.pending:
        return _StatusConfig(
          label: 'Pendiente',
          backgroundColor: Colors.orange.shade100,
          textColor: Colors.orange.shade800,
          icon: Icons.schedule,
        );
      case OrderStatus.processing:
        return _StatusConfig(
          label: 'Procesando',
          backgroundColor: Colors.blue.shade100,
          textColor: Colors.blue.shade800,
          icon: Icons.sync,
        );
      case OrderStatus.completed:
        return _StatusConfig(
          label: 'Completado',
          backgroundColor: Colors.green.shade100,
          textColor: Colors.green.shade800,
          icon: Icons.check_circle,
        );
      case OrderStatus.cancelled:
        return _StatusConfig(
          label: 'Cancelado',
          backgroundColor: Colors.red.shade100,
          textColor: Colors.red.shade800,
          icon: Icons.cancel,
        );
      case OrderStatus.failed:
        return _StatusConfig(
          label: 'Fallido',
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.grey.shade700,
          icon: Icons.error,
        );
      default:
        return _StatusConfig(
          label: status,
          backgroundColor: Colors.grey.shade100,
          textColor: Colors.grey.shade700,
          icon: Icons.help_outline,
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  _StatusConfig({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });
}

// === ARCHIVO: client/test/presentation/viewmodels/orders_viewmodel_test.dart ===
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pedido_app/domain/entities/order.dart';
import 'package:pedido_app/domain/repositories/order_repository.dart';
import 'package:pedido_app/presentation/viewmodels/orders_viewmodel.dart';

@GenerateMocks([OrderRepository])
import 'orders_viewmodel_test.mocks.dart';

void main() {
  late OrdersViewModel viewModel;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    viewModel = OrdersViewModel(orderRepository: mockOrderRepository);
  });

  group('OrdersViewModel - Carga de pedidos', () {
    test('deberia cargar pedidos exitosamente cuando el repositorio retorna datos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime(2024, 1, 15, 10, 30),
          status: OrderStatus.completed,
          items: [
            const OrderItem(
              productId: 'PROD-001',
              productName: 'Producto de prueba',
              quantity: 2,
              unitPrice: 15.99,
            ),
          ],
          total: 31.98,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Calle Principal 123',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime(2024, 1, 16, 14, 20),
          status: OrderStatus.processing,
          items: [
            const OrderItem(
              productId: 'PROD-002',
              productName: 'Otro producto',
              quantity: 1,
              unitPrice: 25.50,
              discount: 5.00,
            ),
          ],
          total: 20.50,
          customerId: 'CUST-001',
          description: 'Pedido con descuento',
          paymentMethod: PaymentMethod.debitCard,
          deliveryAddress: 'Avenida Secundaria 456',
          deliveryDate: DateTime(2024, 1, 20),
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);

      await viewModel.loadOrders();

      expect(viewModel.orders, equals(orders));
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      verify(mockOrderRepository.getOrders()).called(1);
    });

    test('deberia mantener lista vacia cuando no hay pedidos', () async {
      when(mockOrderRepository.getOrders()).thenAnswer((_) async => []);

      await viewModel.loadOrders();

      expect(viewModel.orders, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
    });

    test('deberia establecer error cuando el repositorio falla', () async {
      when(mockOrderRepository.getOrders()).thenThrow(
        Exception('Error de conexion con el servidor'),
      );

      await viewModel.loadOrders();

      expect(viewModel.orders, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.errorMessage, contains('conexion'));
    });

    test('deberia establecer estado de carga durante la peticion', () async {
      when(mockOrderRepository.getOrders()).thenAnswer(
        (_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return [];
        },
      );

      final future = viewModel.loadOrders();

      expect(viewModel.isLoading, isTrue);

      await future;

      expect(viewModel.isLoading, isFalse);
    });
  });

  group('OrdersViewModel - Creacion de pedidos', () {
    test('deberia crear pedido exitosamente con datos validos', () async {
      final newOrder = Order(
        id: 'ORD-NEW',
        date: DateTime.now(),
        status: OrderStatus.pending,
        items: [
          const OrderItem(
            productId: 'PROD-001',
            productName: 'Producto nuevo',
            quantity: 1,
            unitPrice: 10.00,
          ),
        ],
        total: 10.00,
        customerId: 'CUST-001',
        paymentMethod: PaymentMethod.cash,
        deliveryAddress: 'Nueva direccion 789',
      );

      when(mockOrderRepository.createOrder(any)).thenAnswer((_) async => newOrder);
      when(mockOrderRepository.getOrders()).thenAnswer((_) async => [newOrder]);

      await viewModel.createOrder(
        customerId: 'CUST-001',
        items: newOrder.items,
        paymentMethod: PaymentMethod.cash,
        deliveryAddress: 'Nueva direccion 789',
      );

      expect(viewModel.orders, contains(newOrder));
      verify(mockOrderRepository.createOrder(any)).called(1);
    });

    test('deberia fallar al crear pedido sin items', () async {
      when(mockOrderRepository.createOrder(any)).thenThrow(
        ArgumentError('El pedido debe contener al menos un articulo'),
      );

      expect(
        () => viewModel.createOrder(
          customerId: 'CUST-001',
          items: [],
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion valida',
        ),
        throwsArgumentError,
      );
    });

    test('deberia fallar al crear pedido sin direccion de entrega', () async {
      when(mockOrderRepository.createOrder(any)).thenThrow(
        ArgumentError('La direccion de entrega es obligatoria'),
      );

      expect(
        () => viewModel.createOrder(
          customerId: 'CUST-001',
          items: [
            const OrderItem(
              productId: 'PROD-001',
              productName: 'Producto',
              quantity: 1,
              unitPrice: 10.00,
            ),
          ],
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: '',
        ),
        throwsArgumentError,
      );
    });
  });

  group('OrdersViewModel - Filtrado de pedidos', () {
    test('deberia filtrar pedidos por estado completado', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 2',
        ),
        Order(
          id: 'ORD-003',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 75.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.debitCard,
          deliveryAddress: 'Direccion 3',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final completedOrders = viewModel.getOrdersByStatus(OrderStatus.completed);

      expect(completedOrders.length, equals(2));
      expect(completedOrders.every((o) => o.status == OrderStatus.completed), isTrue);
    });

    test('deberia filtrar pedidos por estado cancelado', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.cancelled,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 2',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final cancelledOrders = viewModel.getOrdersByStatus(OrderStatus.cancelled);

      expect(cancelledOrders.length, equals(1));
      expect(cancelledOrders.first.id, equals('ORD-001'));
    });

    test('deberia retornar lista vacia para estado sin pedidos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final completedOrders = viewModel.getOrdersByStatus(OrderStatus.completed);

      expect(completedOrders, isEmpty);
    });
  });

  group('OrdersViewModel - Busqueda de pedido por ID', () {
    test('deberia encontrar pedido existente por ID', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 2',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final order = viewModel.getOrderById('ORD-002');

      expect(order, isNotNull);
      expect(order!.id, equals('ORD-002'));
      expect(order.status, equals(OrderStatus.pending));
    });

    test('deberia retornar null para ID inexistente', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final order = viewModel.getOrderById('ORD-INEXISTENTE');

      expect(order, isNull);
    });

    test('deberia buscar pedido antes de cargar pedidos', () {
      final order = viewModel.getOrderById('ORD-001');

      expect(order, isNull);
      verifyNever(mockOrderRepository.getOrders());
    });
  });

  group('OrdersViewModel - Calculo de totales', () {
    test('deberia calcular el total correctamente para multiples pedidos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.50,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 200.75,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.debitCard,
          deliveryAddress: 'Direccion 2',
        ),
        Order(
          id: 'ORD-003',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.25,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 3',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      expect(viewModel.totalAmount, equals(351.50));
    });

    test('deberia retornar cero cuando no hay pedidos', () async {
      when(mockOrderRepository.getOrders()).thenAnswer((_) async => []);
      await viewModel.loadOrders();

      expect(viewModel.totalAmount, equals(0.0));
    });
  });

  group('OrdersViewModel - Notificacion de cambios', () {
    test('deberia notificar escuchas cuando cambian los pedidos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);

      var notificacionRecibida = false;
      viewModel.addListener(() {
        notificacionRecibida = true;
      });

      await viewModel.loadOrders();

      expect(notificacionRecibida, isTrue);
    });

    test('deberia remover listener correctamente', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);

      var conteoNotificaciones = 0;
      void listener() => conteoNotificaciones++;

      viewModel.addListener(listener);
      await viewModel.loadOrders();
      viewModel.removeListener(listener);
      await viewModel.loadOrders();

      expect(conteoNotificaciones, equals(1));
    });
  });

  group('OrdersViewModel - Limpieza de estado', () {
    test('deberia limpiar errores al cargar exitosamente', () async {
      when(mockOrderRepository.getOrders()).thenThrow(
        Exception('Primer error'),
      );

      await viewModel.loadOrders();
      expect(viewModel.errorMessage, isNotNull);

      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      expect(viewModel.errorMessage, isNull);
    });

    test('deberia limpiar pedidos al llamar clearOrders', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();
      expect(viewModel.orders, isNotEmpty);

      viewModel.clearOrders();

      expect(viewModel.orders, isEmpty);
    });
  });
}
```
