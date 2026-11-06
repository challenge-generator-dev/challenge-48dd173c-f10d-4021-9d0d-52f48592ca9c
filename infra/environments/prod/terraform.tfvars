# Configuración de variables para el entorno de producción
# Estas variables personalizan la infraestructura para producción
# IMPORTANTE: Valores optimizados para alta disponibilidad y rendimiento

# =============================================================================
# CONFIGURACIÓN GENERAL DEL ENTORNO
# =============================================================================

environment = "prod"

# Región primaria de AWS para producción
# us-east-1 es la región recomendada para baja latencia en la costa este de EE.UU.
aws_region = "us-east-1"

# Nombre del proyecto para identificación en recursos
project_name = "pedidos-app"

# Nombre del entorno para distinguir recursos
environment_name = "production"

# =============================================================================
# CONFIGURACIÓN DE LA API
# =============================================================================

# Endpoint base de la API de producción
api_endpoint = "https://api.pedidos.example.com/prod"

# Timeout de la API en segundos (mayor para producción)
api_timeout = 60

# Habilitar CORS para permitir peticiones desde la app móvil
api_cors_enabled = true

# Orígenes permitidos para CORS (dominios oficiales de producción)
api_cors_origins = "https://pedidos.app,https://www.pedidos.app"

# =============================================================================
# CONFIGURACIÓN DE LA FUNCIÓN LAMBDA
# =============================================================================

# Memoria asignada a la función Lambda en MB
# Mayor memoria para mejor rendimiento en producción
lambda_memory_size = 512

# Timeout de ejecución de Lambda en segundos
lambda_timeout = 60

# Número máximo de funciones Lambda concurrentes
# Límite solicitado para alta disponibilidad
lambda_concurrent_executions = 1000

# Habilitar logging detallado de Lambda
lambda_logging_enabled = true

# =============================================================================
# CONFIGURACIÓN DE LA BASE DE DATOS (DynamoDB)
# =============================================================================

# Nombre de la tabla de pedidos
dynamodb_table_name = "pedidos-prod"

# Modo de facturación: PAY_PER_REQUEST (bajo demanda) para optimización de costos
dynamodb_billing_mode = "PAY_PER_REQUEST"

# Capacidad leída provisionada (solo si billing_mode es PROVISIONED)
dynamodb_read_capacity = 20

# Capacidad de escritura provisionada (solo si billing_mode es PROVISIONED)
dynamodb_write_capacity = 20

# Habilitar point-in-time recovery para cumplimiento y seguridad
dynamodb_pitr_enabled = true

# TTL para datos temporales (en días) - retención más larga en producción
dynamodb_ttl_days = 365

# =============================================================================
# CONFIGURACIÓN DE SEGURIDAD
# =============================================================================

# Habilitar protección WAF en API Gateway para protección contra ataques
waf_enabled = true

# Habilitar logs de CloudWatch para API Gateway
api_logging_enabled = true

# Nivel de logging: ERROR, INFO, DEBUG
api_log_level = "ERROR"

# Habilitar API Key para autenticación adicional
api_key_enabled = true

# Política de rate limiting (peticiones por minuto)
api_rate_limit = 1000

# Política de burst (peticiones simultáneas)
api_burst_limit = 500

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
lambda_s3_bucket = "pedidos-app-lambda-prod"

# Clave del objeto en S3
lambda_s3_key = "lambda/pedidos-api-prod.zip"

# Bucket de S3 para el estado remoto de Terraform
terraform_state_bucket = "pedidos-app-terraform-state-prod"

# Clave del estado de Terraform en S3
terraform_state_key = "prod/terraform.tfstate"

# Habilitar bloqueo del estado con DynamoDB para evitar conflictos
terraform_lock_enabled = true

# Nombre de la tabla de bloqueo
terraform_lock_table = "terraform-locks-prod"

# =============================================================================
# CONFIGURACIÓN DE MONITOREO Y ALERTAS
# =============================================================================

# Habilitar métricas personalizadas en CloudWatch
cloudwatch_metrics_enabled = true

# Intervalo de métricas en minutos
cloudwatch_metrics_interval = 1

# Habilitar alertas de CloudWatch para producción
cloudwatch_alerts_enabled = true

# Email para notificaciones de alertas
alert_email = "ops-prod@ejemplo.com"

# Umbral de alertas para errores de Lambda
lambda_error_threshold = 5

# Umbral de alertas para latencia (ms)
lambda_latency_threshold = 1000

# Umbral de alertas para throttling de Lambda
lambda_throttle_threshold = 10

# =============================================================================
# CONFIGURACIÓN DE BACKUP Y RECUPERACIÓN
# =============================================================================

# Habilitar backup automatizado
backup_enabled = true

# Frecuencia de backup: DAILY, WEEKLY, MONTHLY
backup_frequency = "DAILY"

# Retención de backups en días
backup_retention_days = 30

# =============================================================================
# TAGS OBLIGATORIOS PARA TRAZABILIDAD
# =============================================================================

# Tags que se aplicarán a todos los recursos
common_tags = {
  Environment  = "production"
  Project      = "pedidos-app"
  ManagedBy    = "terraform"
  Owner        = "mobile-team"
  CostCenter   = "engineering"
  Compliance   = "hipaa"  # Nivel de cumplimiento más alto para producción
  Backup       = "true"
  Monitoring   = "enhanced"
  SLA          = "99.9"
  Tier         = "production"
}