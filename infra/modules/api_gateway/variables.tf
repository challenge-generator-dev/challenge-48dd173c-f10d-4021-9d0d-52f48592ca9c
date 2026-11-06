# Variables para el módulo de API Gateway
# Este módulo configura la API Gateway que expone los endpoints de la app de pedidos.

variable "api_name" {
  description = "Nombre de la API Gateway"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "Nombre del stage para la API Gateway"
  type        = string
}

variable "cors_allowed_origins" {
  description = "Orígenes permitidos para CORS en la API Gateway"
  type        = list(string)
}

variable "lambda_invoke_arn" {
  description = "ARN de la función Lambda para integrar con la API Gateway"
  type        = string
}

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
}

variable "api_gateway_description" {
  description = "Descripción de la API Gateway"
  type        = string
  default     = "API para la app de pedidos"
}

variable "api_gateway_endpoint_configuration" {
  description = "Configuración de endpoint para la API Gateway (REGIONAL, EDGE, PRIVATE)"
  type        = string
  default     = "REGIONAL"
}