# Módulo de API Gateway para la API de pedidos
# Superficie de práctica - estudiante debe completar la implementación

resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = var.description

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  tags = var.tags
}

# Recurso para el path raíz /orders
resource "aws_api_gateway_resource" "orders" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "orders"
}

# GET /orders - obtener pedidos
resource "aws_api_gateway_method" "orders_get" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "GET"
  authorization = "NONE"
}

# POST /orders - crear pedido
resource "aws_api_gateway_method" "orders_post" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "POST"
  authorization = "NONE"
}

# Recurso para /orders/{orderId}
resource "aws_api_gateway_resource" "order_by_id" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.orders.id
  path_part   = "{orderId}
}

# GET /orders/{orderId}
resource "aws_api_gateway_method" "order_get" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.order_by_id.id
  http_method   = "GET"
  authorization = "NONE"
}

# PATCH /orders/{orderId}/status
resource "aws_api_gateway_resource" "order_status" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.order_by_id.id
  path_part   = "status"
}

resource "aws_api_gateway_method" "order_status_patch" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.order_status.id
  http_method   = "PATCH"
  authorization = "NONE"
}

# Integración con Lambda
resource "aws_api_gateway_integration" "lambda_orders_get" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.orders_get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
}

resource "aws_api_gateway_integration" "lambda_orders_post" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.orders_post.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
}

resource "aws_api_gateway_integration" "lambda_order_get" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.order_by_id.id
  http_method = aws_api_gateway_method.order_get.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
}

resource "aws_api_gateway_integration" "lambda_order_status_patch" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.order_status.id
  http_method = aws_api_gateway_method.order_status_patch.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
}

# CORS - respuesta para preflight
resource "aws_api_gateway_method" "orders_options" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cors_orders" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.orders_options.http_method

  type                = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "cors_orders_response" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.orders_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

# Despliegue del API Gateway
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.lambda_orders_get,
    aws_api_gateway_integration.lambda_orders_post,
    aws_api_gateway_integration.lambda_order_get,
    aws_api_gateway_integration.lambda_order_status_patch
  ]
}

# Stage para el despliegue
resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name

  access_log_settings {
    destination_arn = var.log_group_arn
    format         = "$context.requestId: $context.endpoint $context.httpMethod $context.status $context.responseLatency $context.requestTime"
  }

  tags = var.tags
}