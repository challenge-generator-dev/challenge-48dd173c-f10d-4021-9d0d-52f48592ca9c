# Módulo de Infraestructura - API de Pedidos

Este módulo contiene la infraestructura como código para desplegar la API de la aplicación móvil de pedidos utilizando Terraform.

## Recursos que define este módulo

### API Gateway
- API REST con integración a Lambda
- Endpoints para gestión de pedidos:
  - `GET /orders` - Listar pedidos con filtros
  - `POST /orders` - Crear nuevo pedido
  - `GET /orders/{orderId}` - Obtener detalles de un pedido
  - `PATCH /orders/{orderId}/status` - Actualizar estado de un pedido
- Configuración CORS para permitir solicitudes desde la app móvil
- Stage de producción: `prod`
- Endpoint base: `https://api.pedidos.example.com/prod`

### AWS Lambda
- Función lambda para procesar las peticiones de la API
- Runtime: Python 3.11
- Configuración de memoria: 256 MB
- Timeout: 30 segundos
- Variables de entorno con configuración de la tabla DynamoDB

### Amazon DynamoDB
- Tabla `pedidos` para persistencia de pedidos
- Clave primaria: `orderId` (String)
- Clave de ordenación: `createdAt` (String)
- Modo de facturación: bajo demanda (PAY_PER_REQUEST)
- Índices secundarios para consultas por userId y status

### IAM Roles y Políticas
- Rol de ejecución para Lambda con permisos sobre DynamoDB
- Política de acceso con principio de menor privilegio
- Permisos de CloudWatch para logs

## Uso del módulo

```hcl
module "api_pedidos" {
  source = "./infra"

  environment = "prod"
  region      = "us-east-1"

  # Configuración de la tabla DynamoDB
  table_name = "pedidos"

  # Configuración de la Lambda
  lambda_runtime     = "python3.11"
  lambda_memory_size = 256
  lambda_timeout     = 30

  # Configuración de API Gateway
  api_name = "api-pedidos"

  # Tags obligatorios
  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
    Project     = "app-pedidos"
  }
}
```

## Variables requeridas

| Variable | Descripción | Tipo |
|----------|-------------|------|
| `environment` | Entorno de despliegue (dev, staging, prod) | string |
| `table_name` | Nombre de la tabla DynamoDB | string |

## Variables opcionales

| Variable | Descripción | Valor por defecto |
|----------|-------------|-------------------|
| `region` | Región de AWS | us-east-1 |
| `lambda_runtime` | Runtime de la función Lambda | python3.11 |
| `lambda_memory_size` | Memoria en MB para Lambda | 256 |
| `lambda_timeout` | Timeout en segundos para Lambda | 30 |
| `api_name` | Nombre de la API en API Gateway | api-pedidos |
| `tags` | Tags adicionales para recursos | {} |

## Validación local

Para validar la configuración del módulo antes de aplicar:

```bash
# Inicializar Terraform en el directorio del módulo
cd infra
terraform init

# Validar sintaxis y configuración
terraform validate

# Ver el plan de ejecución
terraform plan
```

Para validar todo el proyecto incluyendo los módulos:

```bash
# Desde la raíz del proyecto
terraform init
terraform validate
terraform plan -var-file="environments/dev/terraform.tfvars"
```

## Endpoints de la API

Una vez desplegada, la API estará disponible en:

- **Base URL**: `https://api.pedidos.example.com/prod`
- **GET /orders**: `https://api.pedidos.example.com/prod/orders?userId={userId}&status={status}&limit={limit}`
- **POST /orders**: `https://api.pedidos.example.com/prod/orders`
- **GET /orders/{orderId}**: `https://api.pedidos.example.com/prod/orders/{orderId}`
- **PATCH /orders/{orderId}/status**: `https://api.pedidos.example.com/prod/orders/{orderId}/status`

## Consideraciones de seguridad

- La API Gateway utiliza IAM para autorización
- Las políticas IAM siguen el principio de menor privilegio
- Los logs de CloudWatch están habilitados para auditoría
- CORS configurado para permitir solo orígenes de la app móvil
- La tabla DynamoDB utiliza encryption at rest

## Troubleshooting

### Error: Lambda no puede acceder a DynamoDB
Verificar que el rol de ejecución de Lambda tenga la política correcta adjunta y que los recursos estén en la misma región.

### Error: CORS blocked
Asegurar que los headers de CORS estén correctamente configurados en la integración de API Gateway y en las respuestas de Lambda.

### Error: Estado de Terraform bloqueado
Si el estado remoto está bloqueado, verificar que no haya otra ejecución de Terraform en curso. El bloqueo se libera automáticamente después del timeout.