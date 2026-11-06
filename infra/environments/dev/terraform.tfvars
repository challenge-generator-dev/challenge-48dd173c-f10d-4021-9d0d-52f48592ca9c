# Configuración de variables para el entorno de desarrollo
# Estas variables personalizan la infraestructura para el entorno de desarrollo

# =============================================================================
# CONFIGURACIÓN GENERAL DEL ENTORNO
# =============================================================================

environment = "dev"

# Región de AWS donde se desplegará la infraestructura
# Usamos us-east-1 como región primaria para desarrollo
aws_region = "us-east-1"

# Nombre del proyecto para identificación en recursos
project_name = "pedidos-app"

# Nombre del entorno para distinguir recursos
environment_name = "development"

# =============================================================================
# CONFIGURACIÓN DE LA API
# =============================================================================

# Endpoint base de la API (simulado para desarrollo)
api_endpoint = "https://api.pedidos.example.com/prod"

# Timeout de la API en segundos
api_timeout = 30

# Habilitar CORS para permitir peticiones desde la app móvil
api_cors_enabled = true

# Orígenes permitidos para CORS (separados por coma)
api_cors_origins = "http://localhost:3000,http://localhost:8080"

# =============================================================================
# CONFIGURACIÓN DE LA FUNCIÓN LAMBDA
# =============================================================================

# Memoria asignada a la función Lambda en MB
lambda_memory_size = 256

# Timeout de ejecución de Lambda en segundos
lambda_timeout = 30

# Número máximo de funciones Lambda concurrentes
lambda_concurrent_executions = 100

# Habilitar logging detallado de Lambda
lambda_logging_enabled = true

# =============================================================================
# CONFIGURACIÓN DE LA BASE DE DATOS (DynamoDB)
# =============================================================================

# Nombre de la tabla de pedidos
dynamodb_table_name = "pedidos-dev"

# Modo de facturación: PAY_PER_REQUEST (bajo demanda) o PROVISIONED
dynamodb_billing_mode = "PAY_PER_REQUEST"

# Capacidad leída provisionada (solo si billing_mode es PROVISIONED)
dynamodb_read_capacity = 5

# Capacidad de escritura provisionada (solo si billing_mode es PROVISIONED)
dynamodb_write_capacity = 5

# Habilitar point-in-time recovery
dynamodb_pitr_enabled = false

# TTL para datos temporales (en días)
dynamodb_ttl_days = 90

# =============================================================================
# CONFIGURACIÓN DE SEGURIDAD
# =============================================================================

# Habilitar protección WAF en API Gateway
waf_enabled = false

# Habilitar logs de CloudWatch para API Gateway
api_logging_enabled = true

# Nivel de logging: ERROR, INFO, DEBUG
api_log_level = "INFO"

# Habilitar API Key para autenticación
api_key_enabled = false

# =============================================================================
# CONFIGURACIÓN DE RED
# =============================================================================

# VPC donde se desplegará la Lambda (opcional)
# Dejar vacío para ejecutar Lambda en VPC default de AWS
vpc_id = ""

# Subnets para la Lambda (requerido si vpc_id está configurado)
# Formato: ["subnet-xxx", "subnet-yyy"]
lambda_subnet_ids = []

# Grupo de seguridad para la Lambda
lambda_security_group_ids = []

# =============================================================================
# CONFIGURACIÓN DE DESPLIEGUE
# =============================================================================

# Bucket de S3 para almacenar el código de la Lambda
lambda_s3_bucket = "pedidos-app-lambda-dev"

# Clave del objeto en S3
lambda_s3_key = "lambda/pedidos-api-dev.zip"

# Bucket de S3 para el estado remoto de Terraform
terraform_state_bucket = "pedidos-app-terraform-state-dev"

# Clave del estado de Terraform en S3
terraform_state_key = "dev/terraform.tfstate"

# Habilitar bloqueo del estado con DynamoDB
terraform_lock_enabled = true

# Nombre de la tabla de bloqueo
terraform_lock_table = "terraform-locks-dev"

# =============================================================================
# CONFIGURACIÓN DE MONITOREO
# =============================================================================

# Habilitar métricas personalizadas en CloudWatch
cloudwatch_metrics_enabled = true

# Intervalo de métricas en minutos
cloudwatch_metrics_interval = 5

# Habilitar alertas de CloudWatch
cloudwatch_alerts_enabled = false

# Email para notificaciones de alertas
alert_email = "devops-dev@ejemplo.com"

# =============================================================================
# TAGS OBLIGATORIOS PARA TRAZABILIDAD
# =============================================================================

# Tags que se aplicarán a todos los recursos
common_tags = {
  Environment  = "development"
  Project      = "pedidos-app"
  ManagedBy    = "terraform"
  Owner        = "mobile-team"
  CostCenter   = "engineering"
  Compliance   = "standard"
  Backup       = "false"
  Monitoring   = "basic"
}