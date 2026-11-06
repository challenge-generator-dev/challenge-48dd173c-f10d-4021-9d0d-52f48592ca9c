# Variables globales para la infraestructura de la app de pedidos
# Estas variables parametrizan la configuración de los módulos y recursos.

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "api_name" {
  description = "Nombre de la API Gateway"
  type        = string
  default     = "pedidos-api"
}

variable "lambda_timeout" {
  description = "Timeout en segundos para las funciones Lambda"
  type        = number
  default     = 30
}

variable "lambda_memory_size" {
  description = "Memoria en MB asignada a las funciones Lambda"
  type        = number
  default     = 256
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para pedidos"
  type        = string
  default     = "pedidos-table"
}

variable "dynamodb_billing_mode" {
  description = "Modo de facturación para DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "api_gateway_stage_name" {
  description = "Nombre del stage para la API Gateway"
  type        = string
  default     = "prod"
}

variable "api_gateway_cors_allowed_origins" {
  description = "Orígenes permitidos para CORS en la API Gateway"
  type        = list(string)
  default     = ["https://app.pedidos.example.com"]
}

variable "lambda_runtime" {
  description = "Runtime para las funciones Lambda"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_handler" {
  description = "Handler para las funciones Lambda"
  type        = string
  default     = "index.handler"
}