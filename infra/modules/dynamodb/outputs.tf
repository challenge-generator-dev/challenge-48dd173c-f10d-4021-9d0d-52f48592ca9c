# Salidas del módulo de DynamoDB
# Superficie de práctica - completar con los outputs necesarios

output "table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.this[0].name
}

output "table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = aws_dynamodb_table.this[0].arn
}

output "table_id" {
  description = "ID de la tabla DynamoDB"
  value       = aws_dynamodb_table.this[0].id
}

output "stream_arn" {
  description = "ARN del stream de la tabla si está habilitado"
  value       = try(aws_dynamodb_table.this[0].stream_arn, null)
}

output "table_endpoint" {
  description = "Endpoint de la tabla DynamoDB"
  value       = "https://dynamodb.${var.region}.amazonaws.com"
}