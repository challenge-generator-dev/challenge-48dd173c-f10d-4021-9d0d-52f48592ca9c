# Salidas del módulo de Lambda
# Superficie de práctica - completar con los outputs necesarios

output "function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.this.function_name
}

output "function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.this.arn
}

output "invoke_arn" {
  description = "ARN de invocación de la función Lambda"
  value       = aws_lambda_function.this.invoke_arn
}

output "role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  value       = aws_iam_role.this.arn
}

output "function_url" {
  description = "URL de la función Lambda si está habilitada"
  value       = try(aws_lambda_function_url.this[0].function_url, null)
}