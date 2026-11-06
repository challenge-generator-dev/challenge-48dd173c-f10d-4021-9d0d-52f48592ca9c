#!/bin/bash
# =============================================================================
# SCRIPT DE VALIDACIÓN DE CONFIGURACIÓN TERRAFORM
# =============================================================================
# Este script valida la configuración de Terraform antes del despliegue.
# Realiza verificaciones de sintaxis, credenciales, variables y estructura
# de módulos para asegurar que el despliegue será exitoso.
#
# Uso: ./scripts/validate.sh [entorno]
# Ejemplo: ./scripts/validate.sh prod
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
readonly COLOR_BOLD='\033[1m'

readonly VALIDATION_LOG="validation_$(date +%Y%m%d_%H%M%S).log"
readonly ERROR_COUNT_FILE="/tmp/terraform_validate_errors.count"

# -----------------------------------------------------------------------------
# VARIABLES GLOBALES
# -----------------------------------------------------------------------------
ERROR_COUNT=0
WARNING_COUNT=0

# -----------------------------------------------------------------------------
# FUNCIONES DE LOG
# -----------------------------------------------------------------------------
log_info() {
    local message="$*"
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} ${message}"
    echo "[INFO] ${message}" >> "${VALIDATION_LOG}"
}

log_success() {
    local message="$*"
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} ${message}"
    echo "[SUCCESS] ${message}" >> "${VALIDATION_LOG}"
}

log_warning() {
    local message="$*"
    ((WARNING_COUNT++))
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} ${message}"
    echo "[WARNING] ${message}" >> "${VALIDATION_LOG}"
}

log_error() {
    local message="$*"
    ((ERROR_COUNT++))
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} ${message}" 1>&2
    echo "[ERROR] ${message}" >> "${VALIDATION_LOG}"
}

log_section() {
    local title="$*"
    echo ""
    echo -e "${COLOR_CYAN}========================================${COLOR_RESET}"
    echo -e "${COLOR_CYAN}  ${title}${COLOR_RESET}"
    echo -e "${COLOR_CYAN}========================================${COLOR_RESET}"
    echo "" >> "${VALIDATION_LOG}"
    echo "======== ${title} ========" >> "${VALIDATION_LOG}"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE PRERREQUISITOS
# -----------------------------------------------------------------------------
check_terraform_installation() {
    log_section "VERIFICACIÓN DE TERRAFORM"
    
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform no está instalado"
        return 1
    fi
    
    local tf_version
    tf_version=$(terraform version -json 2>/dev/null | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
    
    if [[ -z "${tf_version}" ]]; then
        tf_version=$(terraform version 2>&1 | head -n1 | awk '{print $2}')
    fi
    
    log_success "Terraform instalado: ${tf_version}"
    
    if ! terraform fmt -check -recursive &> /dev/null 2>&1; then
        log_warning "Algunos archivos no tienen el formato correcto"
        log_info "Ejecuta: terraform fmt -recursive"
    else
        log_success "Todos los archivos tienen formato correcto"
    fi
}

check_aws_credentials() {
    log_section "VERIFICACIÓN DE CREDENCIALES AWS"
    
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI no está instalado"
        return 1
    fi
    
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "Credenciales de AWS no configuradas o no válidas"
        log_info "Configura tus credenciales: aws configure"
        return 1
    fi
    
    local account_id account_arn account_user
    account_id=$(aws sts get-caller-identity --query 'Account' --output text 2>/dev/null)
    account_arn=$(aws sts get-caller-identity --query 'Arn' --output text 2>/dev/null)
    
    log_success "Cuenta AWS: ${account_id}"
    log_success "ARN: ${account_arn}"
    
    if ! aws s3 ls &> /dev/null; then
        log_error "No hay acceso a S3 con las credenciales actuales"
        return 1
    fi
    
    log_success "Credenciales de AWS válidas"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE ESTRUCTURA DE ARCHIVOS
# -----------------------------------------------------------------------------
check_required_files() {
    log_section "VERIFICACIÓN DE ARCHIVOS REQUERIDOS"
    
    local required_files=(
        "backend.tf"
        "versions.tf"
        "main.tf"
        "variables.tf"
        "outputs.tf"
        "providers.tf"
    )
    
    local all_present=true
    
    for file in "${required_files[@]}"; do
        if [[ -f "${file}" ]]; then
            log_success "Archivo presente: ${file}"
        else
            log_error "Archivo faltante: ${file}"
            all_present=false
        fi
    done
    
    if [[ "${all_present}" == "false" ]]; then
        return 1
    fi
    
    if [[ -d "modules" ]]; then
        log_success "Directorio de módulos presente"
        
        local module_count
        module_count=$(find modules -maxdepth 1 -mindepth 1 -type d | wc -l)
        log_info "Módulos encontrados: ${module_count}"
    else
        log_warning "No se encontró directorio de módulos"
    fi
}

check_terraform_syntax() {
    log_section "VERIFICACIÓN DE SINTAXIS TERRAFORM"
    
    local tf_files
    tf_files=$(find . -name "*.tf" -type f 2>/dev/null)
    
    if [[ -z "${tf_files}" ]]; then
        log_error "No se encontraron archivos .tf"
        return 1
    fi
    
    local syntax_errors=0
    
    for tf_file in ${tf_files}; do
        if ! terraform validate "$(dirname "${tf_file}")" &> /dev/null; then
            log_error "Error de sintaxis en: ${tf_file}"
            ((syntax_errors++))
        fi
    done
    
    if [[ ${syntax_errors} -eq 0 ]]; then
        log_success "Todos los archivos .tf son válidos"
    else
        log_error "Se encontraron ${syntax_errors} errores de sintaxis"
        return 1
    fi
}

check_module_structure() {
    log_section "VERIFICACIÓN DE ESTRUCTURA DE MÓDULOS"
    
    if [[ ! -d "modules" ]]; then
        log_warning "No hay módulos definidos"
        return 0
    fi
    
    local module_dirs
    module_dirs=$(find modules -maxdepth 1 -mindepth 1 -type d)
    
    for module_dir in ${module_dirs}; do
        local module_name
        module_name=$(basename "${module_dir}")
        
        log_info "Verificando módulo: ${module_name}"
        
        if [[ ! -f "${module_dir}/main.tf" ]]; then
            log_error "Módulo ${module_name} sin archivo main.tf"
        fi
        
        if [[ ! -f "${module_dir}/variables.tf" ]]; then
            log_warning "Módulo ${module_name} sin archivo variables.tf"
        fi
        
        if [[ ! -f "${module_dir}/outputs.tf" ]]; then
            log_warning "Módulo ${module_name} sin archivo outputs.tf"
        fi
    done
    
    log_success "Estructura de módulos verificada"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE VARIABLES
# -----------------------------------------------------------------------------
check_variables_configuration() {
    log_section "VERIFICACIÓN DE VARIABLES"
    
    if [[ ! -f "variables.tf" ]]; then
        log_error "Archivo variables.tf no encontrado"
        return 1
    fi
    
    local var_count
    var_count=$(grep -c '^variable "' variables.tf 2>/dev/null || echo "0")
    
    log_info "Variables definidas: ${var_count}"
    
    if [[ ${var_count} -eq 0 ]]; then
        log_warning "No se encontraron variables definidas"
    else
        log_success "Variables configuradas correctamente"
    fi
    
    local required_vars=(
        "aws_region"
        "environment"
        "project_name"
    )
    
    for req_var in "${required_vars[@]}"; do
        if grep -q "variable \"${req_var}\"" variables.tf; then
            log_success "Variable requerida presente: ${req_var}"
        else
            log_warning "Variable requerida no encontrada: ${req_var}"
        fi
    done
}

check_environment_files() {
    log_section "VERIFICACIÓN DE ARCHIVOS DE ENTORNO"
    
    if [[ ! -d "environments" ]]; then
        log_warning "No se encontró directorio de entornos"
        return 0
    fi
    
    local env_dirs
    env_dirs=$(find environments -maxdepth 1 -mindepth 1 -type d 2>/dev/null)
    
    if [[ -z "${env_dirs}" ]]; then
        log_warning "No se encontraron directorios de entorno"
        return 0
    fi
    
    for env_dir in ${env_dirs}; do
        local env_name
        env_name=$(basename "${env_dir}")
        
        log_info "Verificando entorno: ${env_name}"
        
        if [[ -f "${env_dir}/terraform.tfvars" ]]; then
            log_success "Archivo de variables presente: ${env_name}"
        else
            log_warning "Archivo de variables no encontrado: ${env_name}/terraform.tfvars"
        fi
    done
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE SEGURIDAD
# -----------------------------------------------------------------------------
check_security_practices() {
    log_section "VERIFICACIÓN DE PRÁCTICAS DE SEGURIDAD"
    
    if grep -r "aws_secret_key\|aws_access_key\|password\|api_key" . --include="*.tf" 2>/dev/null | grep -v "^#" | grep -v "variable" > /dev/null; then
        log_error "Posibles credenciales hardcodeadas encontradas"
    else
        log_success "No se encontraron credenciales hardcodeadas"
    fi
    
    if grep -r "\"*\"\s*=\s*\s*\"" . --include="*.tf" 2>/dev/null | grep "\.tf:" > /dev/null; then
        log_warning "Posibles valores vacíos encontrados"
    fi
    
    if grep -r "\"true\"" . --include="*.tf" 2>/dev/null | grep -v "\"false\"" | grep -v "\!" > /dev/null; then
        log_info "Verificando configuración de logging"
    fi
}

check_backend_configuration() {
    log_section "VERIFICACIÓN DE CONFIGURACIÓN DE BACKEND"
    
    if [[ ! -f "backend.tf" ]]; then
        log_error "Archivo backend.tf no encontrado"
        return 1
    fi
    
    if grep -q 'backend "s3"' backend.tf; then
        log_success "Backend S3 configurado"
        
        local bucket_name
        bucket_name=$(grep -oP 'bucket\s*=\s*\K"[^"]*"' backend.tf | tr -d '"')
        
        if [[ -n "${bucket_name}" ]]; then
            log_info "Bucket S3: ${bucket_name}"
            
            if aws s3 ls "s3://${bucket_name}" &> /dev/null; then
                log_success "Bucket S3 accesible"
            else
                log_warning "Bucket S3 no accesible o no existe"
            fi
        fi
    else
        log_warning "Backend no configurado con S3"
    fi
}

# -----------------------------------------------------------------------------
# RESUMEN DE VALIDACIÓN
# -----------------------------------------------------------------------------
print_summary() {
    log_section "RESUMEN DE VALIDACIÓN"
    
    echo ""
    echo -e "${COLOR_BOLD}Resultados:${COLOR_RESET}"
    echo -e "  ${COLOR_RED}Errores:   ${ERROR_COUNT}${COLOR_RESET}"
    echo -e "  ${COLOR_YELLOW}Advertencias: ${WARNING_COUNT}${COLOR_RESET}"
    echo ""
    
    if [[ ${ERROR_COUNT} -eq 0 ]]; then
        log_success "Validación completada exitosamente"
        echo -e "${COLOR_GREEN}✓ La configuración de Terraform está lista para el despliegue${COLOR_RESET}"
    else
        log_error "La validación encontró errores que deben resolverse"
        echo -e "${COLOR_RED}✗ Corrige los errores antes de proceder con el despliegue${COLOR_RESET}"
    fi
    
    echo ""
    echo "Log de validación guardado en: ${VALIDATION_LOG}"
    echo ""
}

# -----------------------------------------------------------------------------
# FUNCIÓN PRINCIPAL
# -----------------------------------------------------------------------------
main() {
    local environment="${1:-prod}"
    
    echo ""
    echo -e "${COLOR_BOLD}${COLOR_CYAN}==========================================${COLOR_RESET}"
    echo -e "${COLOR_BOLD}${COLOR_CYAN}  VALIDACIÓN DE CONFIGURACIÓN TERRAFORM${COLOR_RESET}"
    echo -e "${COLOR_BOLD}${COLOR_CYAN}  Entorno: ${environment}${COLOR_RESET}"
    echo -e "${COLOR_BOLD}${COLOR_CYAN}==========================================${COLOR_RESET}"
    echo ""
    
    echo "Iniciando validación..."
    echo "Log de validación: ${VALIDATION_LOG}"
    echo ""> "${VALIDATION_LOG}"
    
    check_terraform_installation || true
    check_aws_credentials || true
    check_required_files || true
    check_terraform_syntax || true
    check_module_structure || true
    check_variables_configuration || true
    check_environment_files || true
    check_security_practices || true
    check_backend_configuration || true
    
    print_summary
    
    if [[ ${ERROR_COUNT} -gt 0 ]]; then
        exit 1
    fi
    
    exit 0
}

# -----------------------------------------------------------------------------
# PUNTO DE ENTRADA
# -----------------------------------------------------------------------------
main "$@"