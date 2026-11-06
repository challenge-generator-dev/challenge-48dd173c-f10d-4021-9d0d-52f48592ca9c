# Salidas del módulo de API Gateway
# Superficie de práctica - estudiante debe completar según necesidades

output "api_gateway_id" {
  description = "ID del API Gateway"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución del API Gateway"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "stageinvoke_url" {
  description = "URL de invocación del stage"
  value       = aws_api_gateway_stage.this.invoke_url
}

output "stage_name" {
  description = "Nombre del stage desplegado"
  value       = aws_api_gateway_stage.this.stage_name
}