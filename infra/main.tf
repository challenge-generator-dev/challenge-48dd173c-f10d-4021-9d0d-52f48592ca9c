# Recursos principales del módulo de infraestructura
# Este archivo es SUPERFICIE DE PRÁCTICA - el candidato debe completar la implementación

# ============================================
# API GATEWAY - Configuración de la API REST
# ============================================

# API Gateway REST API
resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = "API para la aplicación móvil de pedidos"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = var.tags
}

# Configuración de CORS para la API
resource "aws_api_gateway_gateway_response" "default_4xx" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  response_type = "DEFAULT_4XX"

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_gateway_response" "default_5xx" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  response_type = "DEFAULT_5XX"

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# ============================================
# LAMBDA - Función para procesamiento de API
# ============================================

# Rol de ejecución para Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "${var.lambda_function_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Política de acceso a DynamoDB
resource "aws_iam_policy" "dynamodb_access" {
  name = "${var.lambda_function_name}-dynamodb-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = [
          aws_dynamodb_table.this.arn,
          "${aws_dynamodb_table.this.arn}/index/*"
        ]
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

# Política de CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Función Lambda
resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.lambda_function_name
  role            = aws_iam_role.lambda_exec.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  runtime = var.lambda_runtime
  timeout = var.lambda_timeout
  memory_size = var.lambda_memory_size

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.this.name
      REGION     = var.region
    }
  }

  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs
  ]
}

# Permiso para que API Gateway invoque Lambda
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}

# ============================================
# DYNAMODB - Tabla de pedidos
# ============================================

resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "orderId"
  range_key      = "createdAt"

  attribute {
    name = "orderId"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "status"
    type = "S"
  }

  attribute {
    name = "createdAt"
    type = "S"
  }

  # Índice secundario para consultas por userId
  global_secondary_index {
    name            = "userId-index"
    hash_key        = "userId"
    projection_type = "ALL"
  }

  # Índice secundario para consultas por status
  global_secondary_index {
    name            = "status-index"
    hash_key        = "status"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled = true
  }

  ttl {
    attribute_name = "ttl"
    enabled        = false
  }

  tags = var.tags
}

# ============================================
# INTEGRACIÓN API GATEWAY + LAMBDA
# ============================================

# GET /orders
resource "aws_api_gateway_method" "get_orders" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.querystring.userId" = false
    "method.request.querystring.status" = false
    "method.request.querystring.limit"  = false
  }
}

resource "aws_api_gateway_integration" "get_orders" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.get_orders.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

# POST /orders
resource "aws_api_gateway_method" "post_orders" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_orders" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.post_orders.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

# GET /orders/{orderId}
resource "aws_api_gateway_method" "get_order" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.order_id.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.orderId" = true
  }
}

resource "aws_api_gateway_integration" "get_order" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.order_id.id
  http_method = aws_api_gateway_method.get_order.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

# PATCH /orders/{orderId}/status
resource "aws_api_gateway_method" "patch_order_status" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.order_status.id
  http_method   = "PATCH"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.orderId" = true
  }
}

resource "aws_api_gateway_integration" "patch_order_status" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.order_status.id
  http_method = aws_api_gateway_method.patch_order_status.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

# ============================================
# RECURSOS DE API GATEWAY
# ============================================

# Recurso /orders
resource "aws_api_gateway_resource" "orders" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "orders"
}

# Recurso /orders/{orderId}
resource "aws_api_gateway_resource" "order_id" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.orders.id
  path_part   = "{orderId}"
}

# Recurso /orders/{orderId}/status
resource "aws_api_gateway_resource" "order_status" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.order_id.id
  path_part   = "status"
}

# Deployment de API Gateway
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  lifecycle {
    create_before_destroy = true
  }
}

# Stage de producción
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "prod"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway.arn
    format         = "$context.requestId: $context.endpoint $context.httpMethod $context.status $context.responseLatency $context.requestTime"
  }

  tags = var.tags
}

# ============================================
# CLOUDWATCH - Logs y monitoreo
# ============================================

resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/${aws_api_gateway_rest_api.this.name}"
  retention_in_days = 7

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = 7

  tags = var.tags
}

# ============================================
# DATA - Archivo ZIP de Lambda
# ============================================

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}