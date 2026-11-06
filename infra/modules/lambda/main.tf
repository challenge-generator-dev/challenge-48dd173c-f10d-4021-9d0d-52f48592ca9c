# Módulo de función Lambda para la API de pedidos
# Superficie de práctica - estudiante debe completar la implementación

# Rol IAM para la Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  tags = var.tags
}

# Política de logs
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Política de acceso a DynamoDB
resource "aws_iam_policy" "dynamodb_access" {
  name = "${var.function_name}_dynamodb"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:UpdateItem"
      ]
      Resource = var.dynamodb_table_arn
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

# Función Lambda
resource "aws_lambda_function" "this" {
  filename         = var.zip_file
  source_code_hash = var.source_hash
  function_name    = var.function_name
  role            = aws_iam_role.lambda_exec.arn
  handler         = var.handler
  runtime         = var.runtime
  timeout         = var.timeout
  memory_size     = var.memory_size
  environment {
    variables = var.environment_variables
  }

  tracing_config {
    mode = "Active"
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# Permiso para que API Gateway invoque la Lambda
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}

# Alias para versionado
resource "aws_lambda_alias" "this" {
  name             = "live"
  function_name    = aws_lambda_function.this.function_name
  function_version = "$LATEST"
}

# Grupo de logs
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}