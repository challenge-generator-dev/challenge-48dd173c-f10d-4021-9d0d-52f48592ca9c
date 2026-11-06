# Variables para el módulo de DynamoDB
# Este módulo configura la tabla DynamoDB que almacena los pedidos.

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "billing_mode" {
  description = "Modo de facturación para DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
}

variable "hash_key" {
  description = "Clave hash (partition key) para la tabla DynamoDB"
  type        = string
  default     = "orderId"
}

variable "range_key" {
  description = "Clave range (sort key) para la tabla DynamoDB"
  type        = string
  default     = "userId"
}

variable "attribute_definitions" {
  description = "Definiciones de atributos para la tabla DynamoDB"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "orderId"
      type = "S"
    },
    {
      name = "userId"
      type = "S"
    }
  ]
}

variable "global_secondary_indexes" {
  description = "Índices secundarios globales para la tabla DynamoDB"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = [
    {
      name            = "UserOrdersIndex"
      hash_key        = "userId"
      range_key       = "orderId"
      projection_type = "ALL"
      read_capacity   = 5
      write_capacity  = 5
    }
  ]
}

variable "stream_enabled" {
  description = "Habilitar stream para la tabla DynamoDB"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Tipo de vista para el stream de DynamoDB (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}