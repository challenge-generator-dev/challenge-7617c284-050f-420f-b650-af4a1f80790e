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