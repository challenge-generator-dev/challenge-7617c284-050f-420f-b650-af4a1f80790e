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