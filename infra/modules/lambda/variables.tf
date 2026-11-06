# Variables para el módulo de Lambda
# Este módulo configura las funciones Lambda que procesan las solicitudes de la API.

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "lambda_handler" {
  description = "Handler para la función Lambda"
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime para la función Lambda"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout en segundos para la función Lambda"
  type        = number
}

variable "lambda_memory_size" {
  description = "Memoria en MB asignada a la función Lambda"
  type        = number
}

variable "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB para permisos de Lambda"
  type        = string
}

variable "lambda_iam_role_arn" {
  description = "ARN del rol IAM para la función Lambda"
  type        = string
}

variable "lambda_environment_variables" {
  description = "Variables de entorno para la función Lambda"
  type        = map(string)
  default = {
    DYNAMODB_TABLE = "pedidos-table"
    ENVIRONMENT    = "dev"
  }
}