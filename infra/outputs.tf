# Salidas del módulo de infraestructura
# Este archivo es SUPERFICIE DE PRÁCTICA - el candidato debe completar la implementación

# ============================================
# OUTPUTS - API Gateway
# ============================================

output "api_gateway_id" {
  description = "ID de la API Gateway"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_gateway_arn" {
  description = "ARN de la API Gateway"
  value       = aws_api_gateway_rest_api.this.arn
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución de la API Gateway"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "api_endpoint" {
  description = "Endpoint de la API en el stage de producción"
  value       = aws_api_gateway_stage.prod.invoke_url
}

output "api_base_url" {
  description = "URL base completa de la API"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/orders"
}

# ============================================
# OUTPUTS - Lambda
# ============================================

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.this.function_name
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.this.arn
}

output "lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda"
  value       = aws_lambda_function.this.invoke_arn
}

output "lambda_role_name" {
  description = "Nombre del rol de ejecución de Lambda"
  value       = aws_iam_role.lambda_exec.name
}

output "lambda_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  value       = aws_iam_role.lambda_exec.arn
}

# ============================================
# OUTPUTS - DynamoDB
# ============================================

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.this.name
}

output "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = aws_dynamodb_table.this.arn
}

output "dynamodb_table_id" {
  description = "ID de la tabla DynamoDB"
  value       = aws_dynamodb_table.this.id
}

# ============================================
# OUTPUTS - CloudWatch
# ============================================

output "api_gateway_log_group_name" {
  description = "Nombre del grupo de logs de API Gateway"
  value       = aws_cloudwatch_log_group.api_gateway.name
}

output "lambda_log_group_name" {
  description = "Nombre del grupo de logs de Lambda"
  value       = aws_cloudwatch_log_group.lambda.name
}

# ============================================
# OUTPUTS - URLs de endpoints
# ============================================

output "get_orders_url" {
  description = "URL completa para obtener pedidos"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/orders"
}

output "create_order_url" {
  description = "URL completa para crear pedido"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/orders"
}

output "get_order_url" {
  description = "URL completa para obtener un pedido específico"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/orders/{orderId}"
}

output "update_order_status_url" {
  description = "URL completa para actualizar estado de pedido"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/orders/{orderId}/status"
}

# ============================================
# OUTPUTS - Información de recursos
# ============================================

output "all_resource_ids" {
  description = "Mapa con IDs de todos los recursos creados"
  value = {
    api_gateway_id     = aws_api_gateway_rest_api.this.id
    lambda_function_id = aws_lambda_function.this.id
    dynamodb_table_id  = aws_dynamodb_table.this.id
    api_gateway_log_group_id = aws_cloudwatch_log_group.api_gateway.id
    lambda_log_group_id      = aws_cloudwatch_log_group.lambda.id
  }
}