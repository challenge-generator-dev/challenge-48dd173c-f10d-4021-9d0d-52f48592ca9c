#!/bin/bash
# =============================================================================
# SCRIPT DE DESPLIEGUE DE INFRAESTRUCTURA TERRAFORM
# =============================================================================
# Este script automatiza el despliegue de la infraestructura de la API
# de pedidos en AWS. Maneja todo el ciclo de vida de Terraform incluyendo
# inicialización, planificación, validación y aplicación de cambios.
#
# Uso: ./scripts/deploy.sh [entorno]
# Ejemplo: ./scripts/deploy.sh prod
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# CONFIGURACIÓN DE COLORES Y FORMATOS
# -----------------------------------------------------------------------------
readonly COLOR_RESET='\033[0m'
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_CYAN='\033[0;36m'

# -----------------------------------------------------------------------------
# FUNCIONES DE UTILIDAD
# -----------------------------------------------------------------------------
log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $*"
}

log_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $*"
}

log_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} $*"
}

log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $*" 1>&2
}

log_step() {
    echo -e "${COLOR_CYAN}[STEP]${COLOR_RESET} $*"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES PREVIAS AL DESPLIEGUE
# -----------------------------------------------------------------------------
verify_prerequisites() {
    log_step "Verificando prerrequisitos del sistema..."
    
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform no está instalado o no está en el PATH"
        log_info "Instala Terraform usando: brew install terraform (macOS) o consulta la documentación"
        exit 1
    fi
    
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI no está instalado o no está en el PATH"
        log_info "Instala AWS CLI usando: brew install awscli (macOS) o consulta la documentación"
        exit 1
    fi
    
    local terraform_version
    terraform_version=$(terraform version -json 2>/dev/null | grep -o '"version":"[^"]*"' | cut -d'"' -f4 || terraform version 2>&1 | head -n1)
    log_success "Terraform versión: ${terraform_version}"
    
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "Credenciales de AWS no configuradas o no válidas"
        log_info "Configura tus credenciales usando: aws configure"
        exit 1
    fi
    
    local aws_account aws_region
    aws_account=$(aws sts get-caller-identity --query 'Account' --output text 2>/dev/null)
    aws_region=$(aws configure get region 2>/dev/null || echo "us-east-1")
    log_success "Cuenta AWS: ${aws_account}"
    log_success "Región AWS: ${aws_region}"
}

verify_directory_structure() {
    log_step "Verificando estructura de directorios..."
    
    if [[ ! -f "backend.tf" ]]; then
        log_error "No se encontró backend.tf en el directorio raíz"
        exit 1
    fi
    
    if [[ ! -f "main.tf" ]]; then
        log_error "No se encontró main.tf en el directorio raíz"
        exit 1
    fi
    
    if [[ ! -f "versions.tf" ]]; then
        log_error "No se encontró versions.tf en el directorio raíz"
        exit 1
    fi
    
    if [[ ! -d "modules" ]]; then
        log_error "No se encontró el directorio modules/"
        exit 1
    fi
    
    log_success "Estructura de directorios verificada"
}

# -----------------------------------------------------------------------------
# FUNCIONES PRINCIPALES DE DESPLIEGUE
# -----------------------------------------------------------------------------
initialize_terraform() {
    log_step "Inicializando Terraform..."
    
    if [[ -d ".terraform" ]]; then
        log_info "Limpiando estado anterior de Terraform..."
        rm -rf .terraform
    fi
    
    terraform init -upgrade
    
    if [[ $? -eq 0 ]]; then
        log_success "Terraform inicializado correctamente"
    else
        log_error "Error al inicializar Terraform"
        exit 1
    fi
}

validate_terraform_config() {
    log_step "Validando configuración de Terraform..."
    
    terraform validate
    
    if [[ $? -ne 0 ]]; then
        log_error "La validación de Terraform falló"
        exit 1
    fi
    
    log_success "Configuración de Terraform válida"
}

run_terraform_plan() {
    local environment=$1
    log_step "Generando plan de Terraform para entorno: ${environment}..."
    
    local plan_file="terraform_plan_${environment}.tfplan"
    
    if [[ -f "environments/${environment}/terraform.tfvars" ]]; then
        terraform plan -var-file="environments/${environment}/terraform.tfvars" \
                       -out="${plan_file}" \
                       -detailed-exitcode
    else
        log_warning "No se encontró archivo de variables para el entorno: ${environment}"
        log_info "Usando configuración por defecto..."
        terraform plan -out="${plan_file}" -detailed-exitcode
    fi
    
    local plan_exit_code=$?
    
    if [[ ${plan_exit_code} -eq 0 ]]; then
        log_success "No hay cambios que aplicar"
        return 0
    elif [[ ${plan_exit_code} -eq 2 ]]; then
        log_info "Plan generado correctamente. Cambios pendientes de aplicar."
        return 2
    else
        log_error "Error al generar el plan de Terraform"
        exit 1
    fi
}

apply_terraform_changes() {
    local environment=$1
    local plan_file="terraform_plan_${environment}.tfplan"
    
    log_step "Aplicando cambios de Terraform..."
    
    if [[ ! -f "${plan_file}" ]]; then
        log_error "No se encontró el archivo de plan: ${plan_file}"
        log_info "Ejecuta primero el plan para generar el archivo"
        exit 1
    fi
    
    read -p "¿Deseas aplicar los cambios? (sí/no): " confirm
    if [[ "${confirm}" != "sí" && "${confirm}" != "SI" && "${confirm}" != "yes" && "${confirm}" != "YES" ]]; then
        log_info "Aplicación de cambios cancelada por el usuario"
        exit 0
    fi
    
    terraform apply "${plan_file}"
    
    if [[ $? -eq 0 ]]; then
        log_success "Infraestructura aplicada correctamente"
    else
        log_error "Error al aplicar la infraestructura"
        exit 1
    fi
}

show_outputs() {
    log_step "Mostrando outputs del despliegue..."
    
    terraform output
    
    log_success "Despliegue completado"
}

# -----------------------------------------------------------------------------
# FUNCIONES DE LIMPIEZA
# -----------------------------------------------------------------------------
cleanup_temp_files() {
    local environment=$1
    log_info "Limpiando archivos temporales..."
    
    rm -f "terraform_plan_${environment}.tfplan"
    rm -f "terraform_plan_${environment}.tfplan.backup"
    
    log_success "Limpieza completada"
}

# -----------------------------------------------------------------------------
# FUNCIÓN PRINCIPAL
# -----------------------------------------------------------------------------
main() {
    local environment="${1:-prod}"
    
    echo ""
    echo "=========================================="
    echo "  SCRIPT DE DESPLIEGUE DE INFRAESTRUCTURA"
    echo "  Entorno: ${environment}"
    echo "=========================================="
    echo ""
    
    verify_prerequisites
    verify_directory_structure
    initialize_terraform
    validate_terraform_config
    
    local plan_result
    run_terraform_plan "${environment}"
    plan_result=$?
    
    if [[ ${plan_result} -eq 2 ]]; then
        apply_terraform_changes "${environment}"
        show_outputs
    else
        log_info "No hay cambios que aplicar. El entorno ya está actualizado."
    fi
    
    cleanup_temp_files "${environment}"
    
    echo ""
    echo "=========================================="
    echo "  DESPLIEGUE FINALIZADO"
    echo "=========================================="
    echo ""
}

# -----------------------------------------------------------------------------
# PUNTO DE ENTRADA
# -----------------------------------------------------------------------------
main "$@"