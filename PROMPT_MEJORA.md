# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/backend.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api_gateway/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api_gateway/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api_gateway/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/lambda/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/lambda/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/lambda/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/dynamodb/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/dynamodb/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/dynamodb/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://api.pedidos.example.com/prod):
  - `GET /orders`
  - `POST /orders`
  - `GET /orders/{orderId}`
  - `PATCH /orders/{orderId}/status`
- `client` expone http (api: https://api.pedidos.example.com/prod):

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `client/lib/data/repositories/order_repository_impl.dart` — `OrderRemoteDataSource.getOrdersByCustomer`: Se invoca `getOrdersByCustomer` sobre `OrderRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/repositories/order_repository_impl.dart` — `OrderRemoteDataSource.getOrdersByStatus`: Se invoca `getOrdersByStatus` sobre `OrderRemoteDataSource`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `DioClient.get`: Se invoca `get` sobre `DioClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `DioClient.post`: Se invoca `post` sobre `DioClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `DioClient.put`: Se invoca `put` sobre `DioClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `DioClient.delete`: Se invoca `delete` sobre `DioClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261106160222034), Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el despliegue de la API. — entregable (NO resolver): Configuración de Terraform lista para el despliegue de la API.
- Fase 2: Despliegue de la API — objetivo: Desplegar la API utilizando Terraform. — entregable (NO resolver): API desplegada utilizando Terraform y verificada.
- Fase 3: Verificación y optimización — objetivo: Verificar el despliegue y optimizar la configuración de Terraform. — entregable (NO resolver): Configuración optimizada de Terraform y API verificada.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/AndroidManifest.xml ===
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.pragma.mobileapp">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:name=".PragmaApplication"
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.Material3.DayNight.NoActionBar"
        tools:targetApi="34">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/Theme.Material3.DayNight.NoActionBar">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="dagger.hilt.android.module"
            android:value="com.pragma.mobileapp.di.AppModule" />
    </application>

</manifest>

// === ARCHIVO: infra/build.gradle ===
// Este archivo no aplica para proyectos Terraform (HCL).
// Terraform usa 'terraform init' para descargar providers y módulos,
// y su configuración de dependencias se gestiona en 'versions.tf' y 'providers.tf'.
//
// El proyecto ya incluye los archivos requeridos para Terraform:
// - versions.tf (define las versiones de Terraform y providers)
// - providers.tf (declara los providers como hashicorp/aws)
//
// No se necesita un build.gradle en proyectos Terraform.

// === ARCHIVO: infra/providers.tf ===
# Configuración de proveedores para AWS
# Este archivo define los proveedores requeridos para desplegar la infraestructura
# y configura la autenticación con AWS.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.71.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
  required_version = ">= 1.9.8"
}

# Configuración del proveedor AWS
provider "aws" {
  region = var.aws_region
  
  # Tags obligatorios para todos los recursos
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "pedidos-app"
      ManagedBy   = "Terraform"
    }
  }
}

# Variables requeridas para el proveedor
variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Configuración de backend remoto (S3) para el estado de Terraform
# Se define en backend.tf, pero se referencia aquí para claridad

// === ARCHIVO: infra/variables.tf ===
# Variables globales para la infraestructura de la app de pedidos
# Estas variables parametrizan la configuración de los módulos y recursos.

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "api_name" {
  description = "Nombre de la API Gateway"
  type        = string
  default     = "pedidos-api"
}

variable "lambda_timeout" {
  description = "Timeout en segundos para las funciones Lambda"
  type        = number
  default     = 30
}

variable "lambda_memory_size" {
  description = "Memoria en MB asignada a las funciones Lambda"
  type        = number
  default     = 256
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para pedidos"
  type        = string
  default     = "pedidos-table"
}

variable "dynamodb_billing_mode" {
  description = "Modo de facturación para DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "api_gateway_stage_name" {
  description = "Nombre del stage para la API Gateway"
  type        = string
  default     = "prod"
}

variable "api_gateway_cors_allowed_origins" {
  description = "Orígenes permitidos para CORS en la API Gateway"
  type        = list(string)
  default     = ["https://app.pedidos.example.com"]
}

variable "lambda_runtime" {
  description = "Runtime para las funciones Lambda"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_handler" {
  description = "Handler para las funciones Lambda"
  type        = string
  default     = "index.handler"
}

// === ARCHIVO: infra/modules/api_gateway/variables.tf ===
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

// === ARCHIVO: infra/modules/lambda/variables.tf ===
# Variables para el módulo de Lambda
# Este módulo configura las funciones Lambda que procesan las solicitudes de la API.

variable "lambda_function_name" {
  description = "Nombre de la función Lambda"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "lambda_handler" {
  description = "Handler para la función Lambda"
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime para la función Lambda"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout en segundos para la función Lambda"
  type        = number
}

variable "lambda_memory_size" {
  description = "Memoria en MB asignada a la función Lambda"
  type        = number
}

variable "dynamodb_table_arn" {
  description = "ARN de la tabla DynamoDB para permisos de Lambda"
  type        = string
}

variable "lambda_iam_role_arn" {
  description = "ARN del rol IAM para la función Lambda"
  type        = string
}

variable "lambda_environment_variables" {
  description = "Variables de entorno para la función Lambda"
  type        = map(string)
  default = {
    DYNAMODB_TABLE = "pedidos-table"
    ENVIRONMENT    = "dev"
  }
}

// === ARCHIVO: infra/modules/dynamodb/variables.tf ===
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

// === ARCHIVO: infra/README.md ===
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

// === ARCHIVO: infra/main.tf ===
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

// === ARCHIVO: infra/outputs.tf ===
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

// === ARCHIVO: infra/backend.tf ===
terraform {
  backend "s3" {
    bucket         = "tf-state-pedidos-app-prod"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
    
    # Configuracion de bloqueo dinamico para prevenir ejecuciones concurrentes
    # El nombre de la tabla debe coincidir con el recurso DynamoDB en main.tf
    # Esta tabla debe crearse antes de inicializar Terraform con este backend
    # Se recomienda usar billing_mode PAY_PER_REQUEST para costos optimizados
    
    # Versioning del estado para recuperación ante desastres
    # Habilitar versionado en el bucket S3 para mantener historial de estados
    # Esto permite rollback a estados anteriores si es necesario
    
    # Server-side encryption con KMS para mayor seguridad
    # La clave KMS debe administrarse fuera de Terraform para evitar dependencias circulares
    # Se recomienda usar AWS Managed Keys o CMK personalizada según requisitos de compliance
  }
}

# Configuracion de perfiles y roles para diferentes entornos
# El rol IAM debe tener permisos específicos para S3 y DynamoDB
# Se recomienda usar IAM roles en lugar de claves de acceso
#
# Para desarrollo local sin rol: comentar backend y usar local
# locals {
#   backend_config = {
#     bucket = "tf-state-${var.environment}"
#     key    = "${var.environment}/terraform.tfstate"
#   }
# }

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.71"
    }
    
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }
}

# Configuracion del provider AWS con region y perfil
# Se usa region us-east-1 como default pero puede parametrizarse
# El perfil permite切换 entre cuentas AWS si es necesario
provider "aws" {
  region = var.aws_region
  
  # Configuracion de retries para operaciones que pueden fallar temporalmente
  # Esto es util en entornos de alta disponibilidad
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "pedidos-app"
      ManagedBy   = "terraform"
      # Tags obligatorios para trazabilidad y costo
      # Cada recurso desplegado tendra estos tags automaticamente
    }
  }
  
  # Configuracion de endpoints para desarrollo local con LocalStack
  # Descomentar para pruebas locales sin AWS real
  # endpoints {
  #   s3 = "http://localhost:4566"
  #   dynamodb = "http://localhost:4566"
  #   lambda = "http://localhost:4566"
  #   apigateway = "http://localhost:4566"
  # }
}

# Proveedor para generacion de IDs aleatorios
# Usado para nombres de recursos que requieren unicidad
provider "random" {
  # No requiere configuracion especial
  # Las opciones se definen en los recursos que lo usan
}

# Proveedor para templates
# Util para generar contenido dinamico como user data de Lambda
provider "template" {
  # No requiere configuracion especial
}

# Alias para provider en region alternativa si es necesario
# Usar con: provider.aws.alias = "secondary"
# provider "aws" {
#   alias  = "secondary"
#   region = "us-west-2"
# }

// === ARCHIVO: infra/.terraform-version ===
1.9.8

// === ARCHIVO: infra/.gitignore ===
# Terraform state files
*.tfstate
*.tfstate.*
*.tfstate.backup
*.tfstate.*.backup

# Terraform lock files
.terraform.lock.hcl

# Terraform provider plugins
.terraform/

# Variable override files with sensitive data
*.auto.tfvars
*.auto.tfvars.json

# Plan files (can contain sensitive data)
*.plan
*.plan.*

# Backup files
*~
*.bak

# Log files
*.log

# IDE and editor files
.idea/
.vscode/
*.swp
*.swo
*~
.DS_Store

# Environment-specific override files
environments/*/local.tfvars
environments/*/.terraform.lock.hcl

# Lambda deployment packages
*.zip
lambda_function_payload.zip

# Cloud-specific credentials (never commit these)
credentials.json
*.pem
*.key

# Temporary files
tmp/
temp/
*.tmp

# Python virtual environments (if using Python scripts)
venv/
env/
.venv/

# Node modules (if using Node scripts)
node_modules/

# Secret files (explicit list to prevent accidental commits)
secrets.tf
secret*

// === ARCHIVO: infra/modules/api_gateway/main.tf ===
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

// === ARCHIVO: infra/modules/api_gateway/outputs.tf ===
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

// === ARCHIVO: infra/modules/lambda/main.tf ===
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

// === ARCHIVO: infra/modules/lambda/outputs.tf ===
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

// === ARCHIVO: infra/modules/dynamodb/main.tf ===
# Módulo reusable para tabla DynamoDB
# Superficie de práctica - completar con la definición del recurso

resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      projection_type = global_secondary_index.value.projection_type
      read_capacity   = global_secondary_index.value.read_capacity
      write_capacity  = global_secondary_index.value.write_capacity
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes
    content {
      name            = local_secondary_index.value.name
      range_key       = local_secondary_index.value.range_key
      projection_type = local_secondary_index.value.projection_type
    }
  }

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = var.ttl_enabled
  }

  tags = var.tags

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
}

resource "aws_dynamodb_table" "this" {
  count = var.server_side_encryption_enabled ? 1 : 0

  name             = var.table_name
  billing_mode     = var.billing_mode
  hash_key         = var.hash_key
  range_key        = var.range_key
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  server_side_encryption {
    enabled     = true
    kms_key_arn = var.kms_key_arn
  }

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  ttl {
    attribute_name = var.ttl_attribute
    enabled        = var.ttl_enabled
  }

  tags = var.tags
}

// === ARCHIVO: infra/modules/dynamodb/outputs.tf ===
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

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Configuración de variables para el entorno de desarrollo
# Estas variables personalizan la infraestructura para el entorno de desarrollo

# =============================================================================
# CONFIGURACIÓN GENERAL DEL ENTORNO
# =============================================================================

environment = "dev"

# Región de AWS donde se desplegará la infraestructura
# Usamos us-east-1 como región primaria para desarrollo
aws_region = "us-east-1"

# Nombre del proyecto para identificación en recursos
project_name = "pedidos-app"

# Nombre del entorno para distinguir recursos
environment_name = "development"

# =============================================================================
# CONFIGURACIÓN DE LA API
# =============================================================================

# Endpoint base de la API (simulado para desarrollo)
api_endpoint = "https://api.pedidos.example.com/prod"

# Timeout de la API en segundos
api_timeout = 30

# Habilitar CORS para permitir peticiones desde la app móvil
api_cors_enabled = true

# Orígenes permitidos para CORS (separados por coma)
api_cors_origins = "http://localhost:3000,http://localhost:8080"

# =============================================================================
# CONFIGURACIÓN DE LA FUNCIÓN LAMBDA
# =============================================================================

# Memoria asignada a la función Lambda en MB
lambda_memory_size = 256

# Timeout de ejecución de Lambda en segundos
lambda_timeout = 30

# Número máximo de funciones Lambda concurrentes
lambda_concurrent_executions = 100

# Habilitar logging detallado de Lambda
lambda_logging_enabled = true

# =============================================================================
# CONFIGURACIÓN DE LA BASE DE DATOS (DynamoDB)
# =============================================================================

# Nombre de la tabla de pedidos
dynamodb_table_name = "pedidos-dev"

# Modo de facturación: PAY_PER_REQUEST (bajo demanda) o PROVISIONED
dynamodb_billing_mode = "PAY_PER_REQUEST"

# Capacidad leída provisionada (solo si billing_mode es PROVISIONED)
dynamodb_read_capacity = 5

# Capacidad de escritura provisionada (solo si billing_mode es PROVISIONED)
dynamodb_write_capacity = 5

# Habilitar point-in-time recovery
dynamodb_pitr_enabled = false

# TTL para datos temporales (en días)
dynamodb_ttl_days = 90

# =============================================================================
# CONFIGURACIÓN DE SEGURIDAD
# =============================================================================

# Habilitar protección WAF en API Gateway
waf_enabled = false

# Habilitar logs de CloudWatch para API Gateway
api_logging_enabled = true

# Nivel de logging: ERROR, INFO, DEBUG
api_log_level = "INFO"

# Habilitar API Key para autenticación
api_key_enabled = false

# =============================================================================
# CONFIGURACIÓN DE RED
# =============================================================================

# VPC donde se desplegará la Lambda (opcional)
# Dejar vacío para ejecutar Lambda en VPC default de AWS
vpc_id = ""

# Subnets para la Lambda (requerido si vpc_id está configurado)
# Formato: ["subnet-xxx", "subnet-yyy"]
lambda_subnet_ids = []

# Grupo de seguridad para la Lambda
lambda_security_group_ids = []

# =============================================================================
# CONFIGURACIÓN DE DESPLIEGUE
# =============================================================================

# Bucket de S3 para almacenar el código de la Lambda
lambda_s3_bucket = "pedidos-app-lambda-dev"

# Clave del objeto en S3
lambda_s3_key = "lambda/pedidos-api-dev.zip"

# Bucket de S3 para el estado remoto de Terraform
terraform_state_bucket = "pedidos-app-terraform-state-dev"

# Clave del estado de Terraform en S3
terraform_state_key = "dev/terraform.tfstate"

# Habilitar bloqueo del estado con DynamoDB
terraform_lock_enabled = true

# Nombre de la tabla de bloqueo
terraform_lock_table = "terraform-locks-dev"

# =============================================================================
# CONFIGURACIÓN DE MONITOREO
# =============================================================================

# Habilitar métricas personalizadas en CloudWatch
cloudwatch_metrics_enabled = true

# Intervalo de métricas en minutos
cloudwatch_metrics_interval = 5

# Habilitar alertas de CloudWatch
cloudwatch_alerts_enabled = false

# Email para notificaciones de alertas
alert_email = "devops-dev@ejemplo.com"

# =============================================================================
# TAGS OBLIGATORIOS PARA TRAZABILIDAD
# =============================================================================

# Tags que se aplicarán a todos los recursos
common_tags = {
  Environment  = "development"
  Project      = "pedidos-app"
  ManagedBy    = "terraform"
  Owner        = "mobile-team"
  CostCenter   = "engineering"
  Compliance   = "standard"
  Backup       = "false"
  Monitoring   = "basic"
}

// === ARCHIVO: infra/environments/prod/terraform.tfvars ===
# Configuración de variables para el entorno de producción
# Estas variables personalizan la infraestructura para producción
# IMPORTANTE: Valores optimizados para alta disponibilidad y rendimiento

# =============================================================================
# CONFIGURACIÓN GENERAL DEL ENTORNO
# =============================================================================

environment = "prod"

# Región primaria de AWS para producción
# us-east-1 es la región recomendada para baja latencia en la costa este de EE.UU.
aws_region = "us-east-1"

# Nombre del proyecto para identificación en recursos
project_name = "pedidos-app"

# Nombre del entorno para distinguir recursos
environment_name = "production"

# =============================================================================
# CONFIGURACIÓN DE LA API
# =============================================================================

# Endpoint base de la API de producción
api_endpoint = "https://api.pedidos.example.com/prod"

# Timeout de la API en segundos (mayor para producción)
api_timeout = 60

# Habilitar CORS para permitir peticiones desde la app móvil
api_cors_enabled = true

# Orígenes permitidos para CORS (dominios oficiales de producción)
api_cors_origins = "https://pedidos.app,https://www.pedidos.app"

# =============================================================================
# CONFIGURACIÓN DE LA FUNCIÓN LAMBDA
# =============================================================================

# Memoria asignada a la función Lambda en MB
# Mayor memoria para mejor rendimiento en producción
lambda_memory_size = 512

# Timeout de ejecución de Lambda en segundos
lambda_timeout = 60

# Número máximo de funciones Lambda concurrentes
# Límite solicitado para alta disponibilidad
lambda_concurrent_executions = 1000

# Habilitar logging detallado de Lambda
lambda_logging_enabled = true

# =============================================================================
# CONFIGURACIÓN DE LA BASE DE DATOS (DynamoDB)
# =============================================================================

# Nombre de la tabla de pedidos
dynamodb_table_name = "pedidos-prod"

# Modo de facturación: PAY_PER_REQUEST (bajo demanda) para optimización de costos
dynamodb_billing_mode = "PAY_PER_REQUEST"

# Capacidad leída provisionada (solo si billing_mode es PROVISIONED)
dynamodb_read_capacity = 20

# Capacidad de escritura provisionada (solo si billing_mode es PROVISIONED)
dynamodb_write_capacity = 20

# Habilitar point-in-time recovery para cumplimiento y seguridad
dynamodb_pitr_enabled = true

# TTL para datos temporales (en días) - retención más larga en producción
dynamodb_ttl_days = 365

# =============================================================================
# CONFIGURACIÓN DE SEGURIDAD
# =============================================================================

# Habilitar protección WAF en API Gateway para protección contra ataques
waf_enabled = true

# Habilitar logs de CloudWatch para API Gateway
api_logging_enabled = true

# Nivel de logging: ERROR, INFO, DEBUG
api_log_level = "ERROR"

# Habilitar API Key para autenticación adicional
api_key_enabled = true

# Política de rate limiting (peticiones por minuto)
api_rate_limit = 1000

# Política de burst (peticiones simultáneas)
api_burst_limit = 500

# =============================================================================
# CONFIGURACIÓN DE RED
# =============================================================================

# VPC donde se desplegará la Lambda (opcional)
# Dejar vacío para ejecutar Lambda en VPC default de AWS
vpc_id = ""

# Subnets para la Lambda (requerido si vpc_id está configurado)
# Formato: ["subnet-xxx", "subnet-yyy"]
lambda_subnet_ids = []

# Grupo de seguridad para la Lambda
lambda_security_group_ids = []

# =============================================================================
# CONFIGURACIÓN DE DESPLIEGUE
# =============================================================================

# Bucket de S3 para almacenar el código de la Lambda
lambda_s3_bucket = "pedidos-app-lambda-prod"

# Clave del objeto en S3
lambda_s3_key = "lambda/pedidos-api-prod.zip"

# Bucket de S3 para el estado remoto de Terraform
terraform_state_bucket = "pedidos-app-terraform-state-prod"

# Clave del estado de Terraform en S3
terraform_state_key = "prod/terraform.tfstate"

# Habilitar bloqueo del estado con DynamoDB para evitar conflictos
terraform_lock_enabled = true

# Nombre de la tabla de bloqueo
terraform_lock_table = "terraform-locks-prod"

# =============================================================================
# CONFIGURACIÓN DE MONITOREO Y ALERTAS
# =============================================================================

# Habilitar métricas personalizadas en CloudWatch
cloudwatch_metrics_enabled = true

# Intervalo de métricas en minutos
cloudwatch_metrics_interval = 1

# Habilitar alertas de CloudWatch para producción
cloudwatch_alerts_enabled = true

# Email para notificaciones de alertas
alert_email = "ops-prod@ejemplo.com"

# Umbral de alertas para errores de Lambda
lambda_error_threshold = 5

# Umbral de alertas para latencia (ms)
lambda_latency_threshold = 1000

# Umbral de alertas para throttling de Lambda
lambda_throttle_threshold = 10

# =============================================================================
# CONFIGURACIÓN DE BACKUP Y RECUPERACIÓN
# =============================================================================

# Habilitar backup automatizado
backup_enabled = true

# Frecuencia de backup: DAILY, WEEKLY, MONTHLY
backup_frequency = "DAILY"

# Retención de backups en días
backup_retention_days = 30

# =============================================================================
# TAGS OBLIGATORIOS PARA TRAZABILIDAD
# =============================================================================

# Tags que se aplicarán a todos los recursos
common_tags = {
  Environment  = "production"
  Project      = "pedidos-app"
  ManagedBy    = "terraform"
  Owner        = "mobile-team"
  CostCenter   = "engineering"
  Compliance   = "hipaa"  # Nivel de cumplimiento más alto para producción
  Backup       = "true"
  Monitoring   = "enhanced"
  SLA          = "99.9"
  Tier         = "production"
}

// === ARCHIVO: infra/scripts/deploy.sh ===
#!/bin/bash
# =============================================================================
# SCRIPT DE DESPLIEGUE DE INFRAESTRUCTURA TERRAFORM
# =============================================================================
# Este script automatiza el despliegue de la infraestructura de la API
# de pedidos en AWS. Maneja todo el ciclo de vida de Terraform incluyendo
# inicialización, planificación, validación y aplicación de cambios.
#
# Uso: ./scripts/deploy.sh [entorno]
# Ejemplo: ./scripts/deploy.sh prod
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# CONFIGURACIÓN DE COLORES Y FORMATOS
# -----------------------------------------------------------------------------
readonly COLOR_RESET='\033[0m'
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_CYAN='\033[0;36m'

# -----------------------------------------------------------------------------
# FUNCIONES DE UTILIDAD
# -----------------------------------------------------------------------------
log_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $*"
}

log_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $*"
}

log_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} $*"
}

log_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $*" 1>&2
}

log_step() {
    echo -e "${COLOR_CYAN}[STEP]${COLOR_RESET} $*"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES PREVIAS AL DESPLIEGUE
# -----------------------------------------------------------------------------
verify_prerequisites() {
    log_step "Verificando prerrequisitos del sistema..."
    
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform no está instalado o no está en el PATH"
        log_info "Instala Terraform usando: brew install terraform (macOS) o consulta la documentación"
        exit 1
    fi
    
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI no está instalado o no está en el PATH"
        log_info "Instala AWS CLI usando: brew install awscli (macOS) o consulta la documentación"
        exit 1
    fi
    
    local terraform_version
    terraform_version=$(terraform version -json 2>/dev/null | grep -o '"version":"[^"]*"' | cut -d'"' -f4 || terraform version 2>&1 | head -n1)
    log_success "Terraform versión: ${terraform_version}"
    
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "Credenciales de AWS no configuradas o no válidas"
        log_info "Configura tus credenciales usando: aws configure"
        exit 1
    fi
    
    local aws_account aws_region
    aws_account=$(aws sts get-caller-identity --query 'Account' --output text 2>/dev/null)
    aws_region=$(aws configure get region 2>/dev/null || echo "us-east-1")
    log_success "Cuenta AWS: ${aws_account}"
    log_success "Región AWS: ${aws_region}"
}

verify_directory_structure() {
    log_step "Verificando estructura de directorios..."
    
    if [[ ! -f "backend.tf" ]]; then
        log_error "No se encontró backend.tf en el directorio raíz"
        exit 1
    fi
    
    if [[ ! -f "main.tf" ]]; then
        log_error "No se encontró main.tf en el directorio raíz"
        exit 1
    fi
    
    if [[ ! -f "versions.tf" ]]; then
        log_error "No se encontró versions.tf en el directorio raíz"
        exit 1
    fi
    
    if [[ ! -d "modules" ]]; then
        log_error "No se encontró el directorio modules/"
        exit 1
    fi
    
    log_success "Estructura de directorios verificada"
}

# -----------------------------------------------------------------------------
# FUNCIONES PRINCIPALES DE DESPLIEGUE
# -----------------------------------------------------------------------------
initialize_terraform() {
    log_step "Inicializando Terraform..."
    
    if [[ -d ".terraform" ]]; then
        log_info "Limpiando estado anterior de Terraform..."
        rm -rf .terraform
    fi
    
    terraform init -upgrade
    
    if [[ $? -eq 0 ]]; then
        log_success "Terraform inicializado correctamente"
    else
        log_error "Error al inicializar Terraform"
        exit 1
    fi
}

validate_terraform_config() {
    log_step "Validando configuración de Terraform..."
    
    terraform validate
    
    if [[ $? -ne 0 ]]; then
        log_error "La validación de Terraform falló"
        exit 1
    fi
    
    log_success "Configuración de Terraform válida"
}

run_terraform_plan() {
    local environment=$1
    log_step "Generando plan de Terraform para entorno: ${environment}..."
    
    local plan_file="terraform_plan_${environment}.tfplan"
    
    if [[ -f "environments/${environment}/terraform.tfvars" ]]; then
        terraform plan -var-file="environments/${environment}/terraform.tfvars" \
                       -out="${plan_file}" \
                       -detailed-exitcode
    else
        log_warning "No se encontró archivo de variables para el entorno: ${environment}"
        log_info "Usando configuración por defecto..."
        terraform plan -out="${plan_file}" -detailed-exitcode
    fi
    
    local plan_exit_code=$?
    
    if [[ ${plan_exit_code} -eq 0 ]]; then
        log_success "No hay cambios que aplicar"
        return 0
    elif [[ ${plan_exit_code} -eq 2 ]]; then
        log_info "Plan generado correctamente. Cambios pendientes de aplicar."
        return 2
    else
        log_error "Error al generar el plan de Terraform"
        exit 1
    fi
}

apply_terraform_changes() {
    local environment=$1
    local plan_file="terraform_plan_${environment}.tfplan"
    
    log_step "Aplicando cambios de Terraform..."
    
    if [[ ! -f "${plan_file}" ]]; then
        log_error "No se encontró el archivo de plan: ${plan_file}"
        log_info "Ejecuta primero el plan para generar el archivo"
        exit 1
    fi
    
    read -p "¿Deseas aplicar los cambios? (sí/no): " confirm
    if [[ "${confirm}" != "sí" && "${confirm}" != "SI" && "${confirm}" != "yes" && "${confirm}" != "YES" ]]; then
        log_info "Aplicación de cambios cancelada por el usuario"
        exit 0
    fi
    
    terraform apply "${plan_file}"
    
    if [[ $? -eq 0 ]]; then
        log_success "Infraestructura aplicada correctamente"
    else
        log_error "Error al aplicar la infraestructura"
        exit 1
    fi
}

show_outputs() {
    log_step "Mostrando outputs del despliegue..."
    
    terraform output
    
    log_success "Despliegue completado"
}

# -----------------------------------------------------------------------------
# FUNCIONES DE LIMPIEZA
# -----------------------------------------------------------------------------
cleanup_temp_files() {
    local environment=$1
    log_info "Limpiando archivos temporales..."
    
    rm -f "terraform_plan_${environment}.tfplan"
    rm -f "terraform_plan_${environment}.tfplan.backup"
    
    log_success "Limpieza completada"
}

# -----------------------------------------------------------------------------
# FUNCIÓN PRINCIPAL
# -----------------------------------------------------------------------------
main() {
    local environment="${1:-prod}"
    
    echo ""
    echo "=========================================="
    echo "  SCRIPT DE DESPLIEGUE DE INFRAESTRUCTURA"
    echo "  Entorno: ${environment}"
    echo "=========================================="
    echo ""
    
    verify_prerequisites
    verify_directory_structure
    initialize_terraform
    validate_terraform_config
    
    local plan_result
    run_terraform_plan "${environment}"
    plan_result=$?
    
    if [[ ${plan_result} -eq 2 ]]; then
        apply_terraform_changes "${environment}"
        show_outputs
    else
        log_info "No hay cambios que aplicar. El entorno ya está actualizado."
    fi
    
    cleanup_temp_files "${environment}"
    
    echo ""
    echo "=========================================="
    echo "  DESPLIEGUE FINALIZADO"
    echo "=========================================="
    echo ""
}

# -----------------------------------------------------------------------------
# PUNTO DE ENTRADA
# -----------------------------------------------------------------------------
main "$@"

// === ARCHIVO: infra/scripts/validate.sh ===
#!/bin/bash
# =============================================================================
# SCRIPT DE VALIDACIÓN DE CONFIGURACIÓN TERRAFORM
# =============================================================================
# Este script valida la configuración de Terraform antes del despliegue.
# Realiza verificaciones de sintaxis, credenciales, variables y estructura
# de módulos para asegurar que el despliegue será exitoso.
#
# Uso: ./scripts/validate.sh [entorno]
# Ejemplo: ./scripts/validate.sh prod
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# CONFIGURACIÓN DE COLORES Y FORMATOS
# -----------------------------------------------------------------------------
readonly COLOR_RESET='\033[0m'
readonly COLOR_RED='\033[0;31m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_CYAN='\033[0;36m'
readonly COLOR_BOLD='\033[1m'

readonly VALIDATION_LOG="validation_$(date +%Y%m%d_%H%M%S).log"
readonly ERROR_COUNT_FILE="/tmp/terraform_validate_errors.count"

# -----------------------------------------------------------------------------
# VARIABLES GLOBALES
# -----------------------------------------------------------------------------
ERROR_COUNT=0
WARNING_COUNT=0

# -----------------------------------------------------------------------------
# FUNCIONES DE LOG
# -----------------------------------------------------------------------------
log_info() {
    local message="$*"
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} ${message}"
    echo "[INFO] ${message}" >> "${VALIDATION_LOG}"
}

log_success() {
    local message="$*"
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} ${message}"
    echo "[SUCCESS] ${message}" >> "${VALIDATION_LOG}"
}

log_warning() {
    local message="$*"
    ((WARNING_COUNT++))
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} ${message}"
    echo "[WARNING] ${message}" >> "${VALIDATION_LOG}"
}

log_error() {
    local message="$*"
    ((ERROR_COUNT++))
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} ${message}" 1>&2
    echo "[ERROR] ${message}" >> "${VALIDATION_LOG}"
}

log_section() {
    local title="$*"
    echo ""
    echo -e "${COLOR_CYAN}========================================${COLOR_RESET}"
    echo -e "${COLOR_CYAN}  ${title}${COLOR_RESET}"
    echo -e "${COLOR_CYAN}========================================${COLOR_RESET}"
    echo "" >> "${VALIDATION_LOG}"
    echo "======== ${title} ========" >> "${VALIDATION_LOG}"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE PRERREQUISITOS
# -----------------------------------------------------------------------------
check_terraform_installation() {
    log_section "VERIFICACIÓN DE TERRAFORM"
    
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform no está instalado"
        return 1
    fi
    
    local tf_version
    tf_version=$(terraform version -json 2>/dev/null | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
    
    if [[ -z "${tf_version}" ]]; then
        tf_version=$(terraform version 2>&1 | head -n1 | awk '{print $2}')
    fi
    
    log_success "Terraform instalado: ${tf_version}"
    
    if ! terraform fmt -check -recursive &> /dev/null 2>&1; then
        log_warning "Algunos archivos no tienen el formato correcto"
        log_info "Ejecuta: terraform fmt -recursive"
    else
        log_success "Todos los archivos tienen formato correcto"
    fi
}

check_aws_credentials() {
    log_section "VERIFICACIÓN DE CREDENCIALES AWS"
    
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI no está instalado"
        return 1
    fi
    
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "Credenciales de AWS no configuradas o no válidas"
        log_info "Configura tus credenciales: aws configure"
        return 1
    fi
    
    local account_id account_arn account_user
    account_id=$(aws sts get-caller-identity --query 'Account' --output text 2>/dev/null)
    account_arn=$(aws sts get-caller-identity --query 'Arn' --output text 2>/dev/null)
    
    log_success "Cuenta AWS: ${account_id}"
    log_success "ARN: ${account_arn}"
    
    if ! aws s3 ls &> /dev/null; then
        log_error "No hay acceso a S3 con las credenciales actuales"
        return 1
    fi
    
    log_success "Credenciales de AWS válidas"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE ESTRUCTURA DE ARCHIVOS
# -----------------------------------------------------------------------------
check_required_files() {
    log_section "VERIFICACIÓN DE ARCHIVOS REQUERIDOS"
    
    local required_files=(
        "backend.tf"
        "versions.tf"
        "main.tf"
        "variables.tf"
        "outputs.tf"
        "providers.tf"
    )
    
    local all_present=true
    
    for file in "${required_files[@]}"; do
        if [[ -f "${file}" ]]; then
            log_success "Archivo presente: ${file}"
        else
            log_error "Archivo faltante: ${file}"
            all_present=false
        fi
    done
    
    if [[ "${all_present}" == "false" ]]; then
        return 1
    fi
    
    if [[ -d "modules" ]]; then
        log_success "Directorio de módulos presente"
        
        local module_count
        module_count=$(find modules -maxdepth 1 -mindepth 1 -type d | wc -l)
        log_info "Módulos encontrados: ${module_count}"
    else
        log_warning "No se encontró directorio de módulos"
    fi
}

check_terraform_syntax() {
    log_section "VERIFICACIÓN DE SINTAXIS TERRAFORM"
    
    local tf_files
    tf_files=$(find . -name "*.tf" -type f 2>/dev/null)
    
    if [[ -z "${tf_files}" ]]; then
        log_error "No se encontraron archivos .tf"
        return 1
    fi
    
    local syntax_errors=0
    
    for tf_file in ${tf_files}; do
        if ! terraform validate "$(dirname "${tf_file}")" &> /dev/null; then
            log_error "Error de sintaxis en: ${tf_file}"
            ((syntax_errors++))
        fi
    done
    
    if [[ ${syntax_errors} -eq 0 ]]; then
        log_success "Todos los archivos .tf son válidos"
    else
        log_error "Se encontraron ${syntax_errors} errores de sintaxis"
        return 1
    fi
}

check_module_structure() {
    log_section "VERIFICACIÓN DE ESTRUCTURA DE MÓDULOS"
    
    if [[ ! -d "modules" ]]; then
        log_warning "No hay módulos definidos"
        return 0
    fi
    
    local module_dirs
    module_dirs=$(find modules -maxdepth 1 -mindepth 1 -type d)
    
    for module_dir in ${module_dirs}; do
        local module_name
        module_name=$(basename "${module_dir}")
        
        log_info "Verificando módulo: ${module_name}"
        
        if [[ ! -f "${module_dir}/main.tf" ]]; then
            log_error "Módulo ${module_name} sin archivo main.tf"
        fi
        
        if [[ ! -f "${module_dir}/variables.tf" ]]; then
            log_warning "Módulo ${module_name} sin archivo variables.tf"
        fi
        
        if [[ ! -f "${module_dir}/outputs.tf" ]]; then
            log_warning "Módulo ${module_name} sin archivo outputs.tf"
        fi
    done
    
    log_success "Estructura de módulos verificada"
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE VARIABLES
# -----------------------------------------------------------------------------
check_variables_configuration() {
    log_section "VERIFICACIÓN DE VARIABLES"
    
    if [[ ! -f "variables.tf" ]]; then
        log_error "Archivo variables.tf no encontrado"
        return 1
    fi
    
    local var_count
    var_count=$(grep -c '^variable "' variables.tf 2>/dev/null || echo "0")
    
    log_info "Variables definidas: ${var_count}"
    
    if [[ ${var_count} -eq 0 ]]; then
        log_warning "No se encontraron variables definidas"
    else
        log_success "Variables configuradas correctamente"
    fi
    
    local required_vars=(
        "aws_region"
        "environment"
        "project_name"
    )
    
    for req_var in "${required_vars[@]}"; do
        if grep -q "variable \"${req_var}\"" variables.tf; then
            log_success "Variable requerida presente: ${req_var}"
        else
            log_warning "Variable requerida no encontrada: ${req_var}"
        fi
    done
}

check_environment_files() {
    log_section "VERIFICACIÓN DE ARCHIVOS DE ENTORNO"
    
    if [[ ! -d "environments" ]]; then
        log_warning "No se encontró directorio de entornos"
        return 0
    fi
    
    local env_dirs
    env_dirs=$(find environments -maxdepth 1 -mindepth 1 -type d 2>/dev/null)
    
    if [[ -z "${env_dirs}" ]]; then
        log_warning "No se encontraron directorios de entorno"
        return 0
    fi
    
    for env_dir in ${env_dirs}; do
        local env_name
        env_name=$(basename "${env_dir}")
        
        log_info "Verificando entorno: ${env_name}"
        
        if [[ -f "${env_dir}/terraform.tfvars" ]]; then
            log_success "Archivo de variables presente: ${env_name}"
        else
            log_warning "Archivo de variables no encontrado: ${env_name}/terraform.tfvars"
        fi
    done
}

# -----------------------------------------------------------------------------
# VERIFICACIONES DE SEGURIDAD
# -----------------------------------------------------------------------------
check_security_practices() {
    log_section "VERIFICACIÓN DE PRÁCTICAS DE SEGURIDAD"
    
    if grep -r "aws_secret_key\|aws_access_key\|password\|api_key" . --include="*.tf" 2>/dev/null | grep -v "^#" | grep -v "variable" > /dev/null; then
        log_error "Posibles credenciales hardcodeadas encontradas"
    else
        log_success "No se encontraron credenciales hardcodeadas"
    fi
    
    if grep -r "\"*\"\s*=\s*\s*\"" . --include="*.tf" 2>/dev/null | grep "\.tf:" > /dev/null; then
        log_warning "Posibles valores vacíos encontrados"
    fi
    
    if grep -r "\"true\"" . --include="*.tf" 2>/dev/null | grep -v "\"false\"" | grep -v "\!" > /dev/null; then
        log_info "Verificando configuración de logging"
    fi
}

check_backend_configuration() {
    log_section "VERIFICACIÓN DE CONFIGURACIÓN DE BACKEND"
    
    if [[ ! -f "backend.tf" ]]; then
        log_error "Archivo backend.tf no encontrado"
        return 1
    fi
    
    if grep -q 'backend "s3"' backend.tf; then
        log_success "Backend S3 configurado"
        
        local bucket_name
        bucket_name=$(grep -oP 'bucket\s*=\s*\K"[^"]*"' backend.tf | tr -d '"')
        
        if [[ -n "${bucket_name}" ]]; then
            log_info "Bucket S3: ${bucket_name}"
            
            if aws s3 ls "s3://${bucket_name}" &> /dev/null; then
                log_success "Bucket S3 accesible"
            else
                log_warning "Bucket S3 no accesible o no existe"
            fi
        fi
    else
        log_warning "Backend no configurado con S3"
    fi
}

# -----------------------------------------------------------------------------
# RESUMEN DE VALIDACIÓN
# -----------------------------------------------------------------------------
print_summary() {
    log_section "RESUMEN DE VALIDACIÓN"
    
    echo ""
    echo -e "${COLOR_BOLD}Resultados:${COLOR_RESET}"
    echo -e "  ${COLOR_RED}Errores:   ${ERROR_COUNT}${COLOR_RESET}"
    echo -e "  ${COLOR_YELLOW}Advertencias: ${WARNING_COUNT}${COLOR_RESET}"
    echo ""
    
    if [[ ${ERROR_COUNT} -eq 0 ]]; then
        log_success "Validación completada exitosamente"
        echo -e "${COLOR_GREEN}✓ La configuración de Terraform está lista para el despliegue${COLOR_RESET}"
    else
        log_error "La validación encontró errores que deben resolverse"
        echo -e "${COLOR_RED}✗ Corrige los errores antes de proceder con el despliegue${COLOR_RESET}"
    fi
    
    echo ""
    echo "Log de validación guardado en: ${VALIDATION_LOG}"
    echo ""
}

# -----------------------------------------------------------------------------
# FUNCIÓN PRINCIPAL
# -----------------------------------------------------------------------------
main() {
    local environment="${1:-prod}"
    
    echo ""
    echo -e "${COLOR_BOLD}${COLOR_CYAN}==========================================${COLOR_RESET}"
    echo -e "${COLOR_BOLD}${COLOR_CYAN}  VALIDACIÓN DE CONFIGURACIÓN TERRAFORM${COLOR_RESET}"
    echo -e "${COLOR_BOLD}${COLOR_CYAN}  Entorno: ${environment}${COLOR_RESET}"
    echo -e "${COLOR_BOLD}${COLOR_CYAN}==========================================${COLOR_RESET}"
    echo ""
    
    echo "Iniciando validación..."
    echo "Log de validación: ${VALIDATION_LOG}"
    echo ""> "${VALIDATION_LOG}"
    
    check_terraform_installation || true
    check_aws_credentials || true
    check_required_files || true
    check_terraform_syntax || true
    check_module_structure || true
    check_variables_configuration || true
    check_environment_files || true
    check_security_practices || true
    check_backend_configuration || true
    
    print_summary
    
    if [[ ${ERROR_COUNT} -gt 0 ]]; then
        exit 1
    fi
    
    exit 0
}

# -----------------------------------------------------------------------------
# PUNTO DE ENTRADA
# -----------------------------------------------------------------------------
main "$@"

// === ARCHIVO: client/pubspec.yaml ===
name: pedidos_app
description: Aplicación móvil para gestión de pedidos

version: 1.0.0+1

environment:
  sdk: '>=3.6.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  dio: ^5.7.0
  equatable: ^2.0.5
  get_it: ^8.0.2
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  json_serializable: ^6.8.0
  build_runner: ^2.4.13

flutter:
  uses-material-design: true
  assets:
    - assets/images/

// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pedidos_app/core/constants/app_colors.dart';
import 'package:pedidos_app/core/network/api_client.dart';
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';
import 'package:pedidos_app/data/repositories/order_repository_impl.dart';
import 'package:pedidos_app/data/datasources/order_remote_datasource.dart';
import 'package:pedidos_app/presentation/screens/orders_screen.dart';
import 'package:pedidos_app/presentation/screens/order_detail_screen.dart';
import 'package:pedidos_app/presentation/screens/create_order_screen.dart';
import 'package:pedidos_app/presentation/viewmodels/orders_viewmodel.dart';

final GetIt getIt = GetIt.instance;

Future<void> _setupDependencies() async {
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient('https://api.pedidos.example.com/prod'),
  );

  getIt.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt<OrderRemoteDataSource>()),
  );

  getIt.registerFactory<OrdersViewModel>(
    () => OrdersViewModel(getIt<OrderRepository>()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupDependencies();
  runApp(const PedidosApp());
}

class PedidosApp extends StatelessWidget {
  const PedidosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrdersViewModel>(),
      child: MaterialApp(
        title: 'Pedidos App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.surface,
            error: AppColors.error,
          ),
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            elevation: 0,
            centerTitle: true,
          ),
          cardTheme: CardTheme(
            color: AppColors.surface,
            elevation: AppColors.shadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.onSecondary,
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (_) => const OrdersScreen(),
              );
            case '/order-detail':
              final orderId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => OrderDetailScreen(orderId: orderId),
              );
            case '/create-order':
              return MaterialPageRoute(
                builder: (_) => const CreateOrderScreen(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const OrdersScreen(),
              );
          }
        },
      ),
    );
  }
}

// === ARCHIVO: client/lib/core/constants/api_constants.dart ===
// Responsable de definir las constantes relacionadas con la configuración de la API.

part of '../../pedidos_app.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.pedidos.example.com/prod';
  static const String ordersEndpoint = '/orders';
  static const String orderDetailEndpoint = '/orders/{id}';
  static const String createOrderEndpoint = '/orders';
  static const String updateOrderEndpoint = '/orders/{id}';
  static const String deleteOrderEndpoint = '/orders/{id}';
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;
  static const int sendTimeout = 3000;
  static const String contentType = 'application/json';
  static const String authorizationHeader = 'Authorization';

  static String getOrderDetailUrl(String id) {
    return orderDetailEndpoint.replaceFirst('{id}', id);
  }

  static String getUpdateOrderUrl(String id) {
    return updateOrderEndpoint.replaceFirst('{id}', id);
  }

  static String getDeleteOrderUrl(String id) {
    return deleteOrderEndpoint.replaceFirst('{id}', id);
  }

  static Map<String, String> getHeaders(String? token) {
    final headers = <String, String>{
      'Content-Type': contentType,
    };
    if (token != null) {
      headers[authorizationHeader] = 'Bearer $token';
    }
    return headers;
  }
}

// === ARCHIVO: client/lib/core/constants/app_colors.dart ===
// Define la paleta de colores utilizada en toda la aplicación siguiendo Material Design 3.

part of '../../pedidos_app.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFF79747E);
  static const Color shadow = Color(0xFF000000);
  static const Color inverseSurface = Color(0xFF1C1B1F);
  static const Color inversePrimary = Color(0xFFD0BCFF);

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF6200EE,
    <int, Color>{
      50: Color(0xFFF2E7FE),
      100: Color(0xFFE2D0FC),
      200: Color(0xFFC8A9FA),
      300: Color(0xFFAE82F8),
      400: Color(0xFF9A61F6),
      500: Color(0xFF6200EE),
      600: Color(0xFF5A00E8),
      700: Color(0xFF5000D9),
      800: Color(0xFF4700CC),
      900: Color(0xFF3700B3),
    },
  );
}

// === ARCHIVO: client/lib/core/network/api_client.dart ===
// Cliente HTTP que utiliza Dio para realizar llamadas a la API de pedidos.
// Maneja autenticación, errores y configuración de timeouts.

import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/network/api_exception.dart';

class DioClient {
  final Dio _dio;
  final String baseUrl;

  DioClient({required this.baseUrl}) : _dio = Dio() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: ApiConstants.connectTimeout);
    _dio.options.receiveTimeout = const Duration(milliseconds: ApiConstants.receiveTimeout);
    _dio.options.sendTimeout = const Duration(milliseconds: ApiConstants.sendTimeout);
    _dio.options.contentType = ApiConstants.contentType;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Aquí se podría agregar lógica para tokens de autenticación
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response != null) {
            final errorResponse = e.response!.data;
            final statusCode = e.response!.statusCode;
            throw ApiException(
              message: errorResponse['message'] ?? 'Error desconocido',
              statusCode: statusCode ?? 500,
              details: errorResponse,
            );
          } else {
            throw ApiException(
              message: e.message ?? 'Error de conexión',
              statusCode: 500,
              details: {'error': e.toString()},
            );
          }
        },
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options ?? Options(headers: ApiConstants.getHeaders(token)),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: ApiConstants.getHeaders(token)),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    String? token,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: ApiConstants.getHeaders(token)),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    String? token,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: ApiConstants.getHeaders(token)),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  ApiException _handleDioError(DioException error) {
    if (error.response != null) {
      final errorResponse = error.response!.data;
      return ApiException(
        message: errorResponse['message'] ?? 'Error en la solicitud',
        statusCode: error.response!.statusCode ?? 500,
        details: errorResponse,
      );
    } else {
      return ApiException(
        message: error.message ?? 'Error de conexión',
        statusCode: 500,
        details: {'error': error.toString()},
      );
    }
  }
}

// === ARCHIVO: client/lib/core/network/api_exception.dart ===
import 'package:equatable/equatable.dart';

enum ApiErrorType {
  connectionError,
  timeout,
  serverError,
  unauthorized,
  forbidden,
  notFound,
  badRequest,
  unknown,
}

class ApiException extends Equatable implements Exception {
  final String message;
  final int? statusCode;
  final ApiErrorType type;
  final dynamic originalError;

  const ApiException({
    required this.message,
    this.statusCode,
    required this.type,
    this.originalError,
  });

  @override
  List<Object?> get props => [message, statusCode, type, originalError];

  @override
  String toString() => 'ApiException: $message (code: $statusCode, type: $type)';

  factory ApiException.connectionError([String? detail]) {
    return ApiException(
      message: detail ?? 'No se pudo conectar al servidor. Verifica tu conexión a internet.',
      type: ApiErrorType.connectionError,
    );
  }

  factory ApiException.timeout([String? detail]) {
    return ApiException(
      message: detail ?? 'La solicitud tardó demasiado. Intenta de nuevo.',
      type: ApiErrorType.timeout,
    );
  }

  factory ApiException.serverError([String? detail, int? code]) {
    return ApiException(
      message: detail ?? 'Error del servidor. Intenta más tarde.',
      statusCode: code ?? 500,
      type: ApiErrorType.serverError,
    );
  }

  factory ApiException.unauthorized([String? detail]) {
    return ApiException(
      message: detail ?? 'Sesión expirada. Inicia sesión nuevamente.',
      statusCode: 401,
      type: ApiErrorType.unauthorized,
    );
  }

  factory ApiException.forbidden([String? detail]) {
    return ApiException(
      message: detail ?? 'No tienes permisos para realizar esta acción.',
      statusCode: 403,
      type: ApiErrorType.forbidden,
    );
  }

  factory ApiException.notFound([String? detail]) {
    return ApiException(
      message: detail ?? 'Recurso no encontrado.',
      statusCode: 404,
      type: ApiErrorType.notFound,
    );
  }

  factory ApiException.badRequest(String detail) {
    return ApiException(
      message: detail,
      statusCode: 400,
      type: ApiErrorType.badRequest,
    );
  }

  factory ApiException.unknown([String? detail, dynamic error]) {
    return ApiException(
      message: detail ?? 'Ocurrió un error inesperado.',
      type: ApiErrorType.unknown,
      originalError: error,
    );
  }

  static ApiException fromDioError(dynamic error) {
    if (error == null) {
      return ApiException.unknown();
    }

    final errorType = error.type?.toString() ?? '';
    final statusCode = error.response?.statusCode;
    String message = 'Error de conexión';

    if (errorType.contains('connectionTimeout') ||
        errorType.contains('receiveTimeout') ||
        errorType.contains('sendTimeout')) {
      return ApiException.timeout();
    }

    if (errorType.contains('connectionError') ||
        errorType.contains('connectionFailed')) {
      return ApiException.connectionError();
    }

    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          final data = error.response?.data;
          message = data is Map ? data['message']?.toString() ?? 'Solicitud inválida' : 'Solicitud inválida';
          return ApiException.badRequest(message);
        case 401:
          return ApiException.unauthorized();
        case 403:
          return ApiException.forbidden();
        case 404:
          return ApiException.notFound();
        case 500:
        case 501:
        case 502:
        case 503:
          return ApiException.serverError();
        default:
          message = error.response?.data?['message']?.toString() ?? 
                    error.response?.statusMessage ?? 
                    'Error HTTP: $statusCode';
          return ApiException(
            message: message,
            statusCode: statusCode,
            type: ApiErrorType.unknown,
            originalError: error,
          );
      }
    }

    return ApiException.unknown(null, error);
  }
}

// === ARCHIVO: client/lib/domain/entities/order.dart ===
package domain.entities;

import 'package:equatable/equatable.dart';
import 'order_item.dart';

class Order extends Equatable {
  final String id;
  final String customerId;
  final List<OrderItem> items;
  final OrderStatus status;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? shippingAddress;
  final String? notes;

  const Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    this.shippingAddress,
    this.notes,
  });

  double calculateTotal() {
    if (items.isEmpty) return 0.0;
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  bool get canBeModified {
    return status == OrderStatus.pending || status == OrderStatus.confirmed;
  }

  bool get canBeCancelled {
    return status != OrderStatus.cancelled && status != OrderStatus.delivered;
  }

  Order copyWith({
    String? id,
    String? customerId,
    List<OrderItem>? items,
    OrderStatus? status,
    double? totalAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? shippingAddress,
    String? notes,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        items,
        status,
        totalAmount,
        createdAt,
        updatedAt,
        shippingAddress,
        notes,
      ];
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.processing:
        return 'Procesando';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  bool get isActive {
    return this == OrderStatus.pending ||
        this == OrderStatus.confirmed ||
        this == OrderStatus.processing ||
        this == OrderStatus.shipped;
  }
}

// === ARCHIVO: client/lib/domain/entities/order_item.dart ===
package domain.entities;

import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final String? imageUrl;
  final String? notes;

  const OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.imageUrl,
    this.notes,
  });

  double get subtotal {
    return quantity * unitPrice;
  }

  bool get isValid {
    return productId.isNotEmpty &&
        productName.isNotEmpty &&
        quantity > 0 &&
        unitPrice >= 0;
  }

  OrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    String? imageUrl,
    String? notes,
  }) {
    return OrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        quantity,
        unitPrice,
        imageUrl,
        notes,
      ];
}

// === ARCHIVO: client/lib/domain/repositories/order_repository.dart ===
package domain.repositories;

import '../entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders({int page = 1, int limit = 20});
  
  Future<Order> getOrderById(String id);
  
  Future<Order> createOrder(Order order);
  
  Future<Order> updateOrder(String id, Order order);
  
  Future<bool> deleteOrder(String id);
  
  Future<List<Order>> getOrdersByCustomer(String customerId);
  
  Future<List<Order>> getOrdersByStatus(OrderStatus status);
}

// === ARCHIVO: client/lib/data/models/order_model.dart ===
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String deliveryAddress;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;
  final String paymentMethod;
  final String? paymentStatus;
  final String? trackingNumber;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.notes,
    required this.paymentMethod,
    this.paymentStatus,
    this.trackingNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? deliveryAddress,
    List<OrderItemModel>? items,
    double? totalAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    String? paymentMethod,
    String? paymentStatus,
    String? trackingNumber,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      trackingNumber: trackingNumber ?? this.trackingNumber,
    );
  }

  double calculateTotal() {
    if (items.isEmpty) return 0.0;
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  bool get isPending => status.toLowerCase() == 'pending';
  bool get isConfirmed => status.toLowerCase() == 'confirmed';
  bool get isProcessing => status.toLowerCase() == 'processing';
  bool get isShipped => status.toLowerCase() == 'shipped';
  bool get isDelivered => status.toLowerCase() == 'delivered';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

  int get itemCount => items.length;

  int get totalQuantity {
    if (items.isEmpty) return 0;
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        customerEmail,
        customerPhone,
        deliveryAddress,
        items,
        totalAmount,
        status,
        createdAt,
        updatedAt,
        notes,
        paymentMethod,
        paymentStatus,
        trackingNumber,
      ];
}

// === ARCHIVO: client/lib/data/models/order_item_model.dart ===
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel extends Equatable {
  final String id;
  final String orderId;
  final String productId;
  final String productName;
  final String productSku;
  final int quantity;
  final double unitPrice;
  final double discount;
  final double taxAmount;
  final String? productImageUrl;
  final String? variantId;
  final String? variantName;

  const OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productSku,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0.0,
    this.taxAmount = 0.0,
    this.productImageUrl,
    this.variantId,
    this.variantName,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  double get subtotal {
    final baseTotal = unitPrice * quantity;
    final discountAmount = baseTotal * (discount / 100);
    return baseTotal - discountAmount + taxAmount;
  }

  double get effectiveUnitPrice {
    final discountAmount = unitPrice * (discount / 100);
    return unitPrice - discountAmount;
  }

  double get totalDiscount => unitPrice * quantity * (discount / 100);

  OrderItemModel copyWith({
    String? id,
    String? orderId,
    String? productId,
    String? productName,
    String? productSku,
    int? quantity,
    double? unitPrice,
    double? discount,
    double? taxAmount,
    String? productImageUrl,
    String? variantId,
    String? variantName,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSku: productSku ?? this.productSku,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discount: discount ?? this.discount,
      taxAmount: taxAmount ?? this.taxAmount,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
    );
  }

  bool get hasDiscount => discount > 0;
  bool get hasVariant => variantId != null && variantName != null;
  bool get isTaxable => taxAmount > 0;

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        productName,
        productSku,
        quantity,
        unitPrice,
        discount,
        taxAmount,
        productImageUrl,
        variantId,
        variantName,
      ];
}

// === ARCHIVO: client/lib/data/repositories/order_repository_impl.dart ===
import 'package:pedidos_app/domain/entities/order.dart';
import 'package:pedidos_app/domain/repositories/order_repository.dart';
import 'package:pedidos_app/data/datasources/order_remote_datasource.dart';
import 'package:pedidos_app/data/models/order_model.dart';
import 'package:pedidos_app/core/network/api_exception.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Order>> getOrders() async {
    try {
      final orderModels = await _remoteDataSource.getOrders();
      return orderModels.map(_mapModelToEntity).toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Error al obtener los pedidos: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> getOrderById(String id) async {
    try {
      final orderModel = await _remoteDataSource.getOrderById(id);
      return _mapModelToEntity(orderModel);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Error al obtener el pedido: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> createOrder(Order order) async {
    try {
      final orderModel = _mapEntityToModel(order);
      final createdModel = await _remoteDataSource.createOrder(orderModel);
      return _mapModelToEntity(createdModel);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Error al crear el pedido: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> updateOrder(String id, Order order) async {
    try {
      final orderModel = _mapEntityToModel(order);
      final updatedModel = await _remoteDataSource.updateOrder(id, orderModel);
      return _mapModelToEntity(updatedModel);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Error al actualizar el pedido: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> deleteOrder(String id) async {
    try {
      await _remoteDataSource.deleteOrder(id);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Error al eliminar el pedido: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<List<Order>> getOrdersByCustomer(String customerId) async {
    try {
      final orderModels = await _remoteDataSource.getOrdersByCustomer(customerId);
      return orderModels.map(_mapModelToEntity).toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Error al obtener pedidos del cliente: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<List<Order>> getOrdersByStatus(String status) async {
    try {
      final orderModels = await _remoteDataSource.getOrdersByStatus(status);
      return orderModels.map(_mapModelToEntity).toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: 'Error al obtener pedidos por estado: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  Order _mapModelToEntity(OrderModel model) {
    return Order(
      id: model.id,
      customerId: model.customerId,
      customerName: model.customerName,
      customerEmail: model.customerEmail,
      customerPhone: model.customerPhone,
      deliveryAddress: model.deliveryAddress,
      items: model.items.map(_mapItemModelToEntity).toList(),
      totalAmount: model.totalAmount,
      status: model.status,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      notes: model.notes,
      paymentMethod: model.paymentMethod,
      paymentStatus: model.paymentStatus,
      trackingNumber: model.trackingNumber,
    );
  }

  OrderModel _mapEntityToModel(Order entity) {
    return OrderModel(
      id: entity.id,
      customerId: entity.customerId,
      customerName: entity.customerName,
      customerEmail: entity.customerEmail,
      customerPhone: entity.customerPhone,
      deliveryAddress: entity.deliveryAddress,
      items: entity.items.map(_mapItemEntityToModel).toList(),
      totalAmount: entity.totalAmount,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      notes: entity.notes,
      paymentMethod: entity.paymentMethod,
      paymentStatus: entity.paymentStatus,
      trackingNumber: entity.trackingNumber,
    );
  }

  OrderItem _mapItemModelToEntity(OrderItemModel model) {
    return OrderItem(
      id: model.id,
      orderId: model.orderId,
      productId: model.productId,
      productName: model.productName,
      productSku: model.productSku,
      quantity: model.quantity,
      unitPrice: model.unitPrice,
      discount: model.discount,
      taxAmount: model.taxAmount,
      productImageUrl: model.productImageUrl,
      variantId: model.variantId,
      variantName: model.variantName,
    );
  }

  OrderItemModel _mapItemEntityToModel(OrderItem entity) {
    return OrderItemModel(
      id: entity.id,
      orderId: entity.orderId,
      productId: entity.productId,
      productName: entity.productName,
      productSku: entity.productSku,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
      discount: entity.discount,
      taxAmount: entity.taxAmount,
      productImageUrl: entity.productImageUrl,
      variantId: entity.variantId,
      variantName: entity.variantName,
    );
  }
}

// === ARCHIVO: client/lib/data/datasources/order_remote_datasource.dart ===
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../../core/constants/api_constants.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String id);
  Future<OrderModel> createOrder(OrderModel order);
  Future<OrderModel> updateOrder(String id, OrderModel order);
  Future<void> deleteOrder(String id);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final DioClient _dioClient;
  
  OrderRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _dioClient.get(<String, dynamic>{
        'endpoint': ApiConstants.ordersEndpoint,
        'options': Options(
          headers: ApiConstants.getHeaders(null),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          sendTimeout: Duration(milliseconds: ApiConstants.sendTimeout),
        ),
      });
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          message: 'Error al obtener la lista de pedidos',
          statusCode: response.statusCode ?? 0,
          error: response.data,
        );
      }
    } on DioException catch (e) {
      throw _dioClient._handleDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'Error inesperado al obtener pedidos: ${e.toString()}',
        statusCode: 0,
        error: e,
      );
    }
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    if (id.isEmpty) {
      throw ApiException(
        message: 'El ID del pedido no puede estar vacío',
        statusCode: 400,
        error: null,
      );
    }
    
    try {
      final url = ApiConstants.getOrderDetailUrl(id);
      final response = await _dioClient.get(<String, dynamic>{
        'endpoint': url,
        'options': Options(
          headers: ApiConstants.getHeaders(null),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          sendTimeout: Duration(milliseconds: ApiConstants.sendTimeout),
        ),
      });
      
      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ApiException(
          message: 'Pedido no encontrado con ID: $id',
          statusCode: 404,
          error: response.data,
        );
      } else {
        throw ApiException(
          message: 'Error al obtener el detalle del pedido',
          statusCode: response.statusCode ?? 0,
          error: response.data,
        );
      }
    } on DioException catch (e) {
      throw _dioClient._handleDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'Error inesperado al obtener pedido: ${e.toString()}',
        statusCode: 0,
        error: e,
      );
    }
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    if (order == null) {
      throw ApiException(
        message: 'El pedido no puede ser nulo',
        statusCode: 400,
        error: null,
      );
    }
    
    try {
      final response = await _dioClient.post(<String, dynamic>{
        'endpoint': ApiConstants.createOrderEndpoint,
        'data': order.toJson(),
        'options': Options(
          headers: ApiConstants.getHeaders(null),
          contentType: ApiConstants.contentType,
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          sendTimeout: Duration(milliseconds: ApiConstants.sendTimeout),
        ),
      });
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return OrderModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ApiException(
          message: 'Error al crear el pedido',
          statusCode: response.statusCode ?? 0,
          error: response.data,
        );
      }
    } on DioException catch (e) {
      throw _dioClient._handleDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'Error inesperado al crear pedido: ${e.toString()}',
        statusCode: 0,
        error: e,
      );
    }
  }

  @override
  Future<OrderModel> updateOrder(String id, OrderModel order) async {
    if (id.isEmpty) {
      throw ApiException(
        message: 'El ID del pedido no puede estar vacío',
        statusCode: 400,
        error: null,
      );
    }
    
    if (order == null) {
      throw ApiException(
        message: 'El pedido no puede ser nulo',
        statusCode: 400,
        error: null,
      );
    }
    
    try {
      final url = ApiConstants.getUpdateOrderUrl(id);
      final response = await _dioClient.put(<String, dynamic>{
        'endpoint': url,
        'data': order.toJson(),
        'options': Options(
          headers: ApiConstants.getHeaders(null),
          contentType: ApiConstants.contentType,
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          sendTimeout: Duration(milliseconds: ApiConstants.sendTimeout),
        ),
      });
      
      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ApiException(
          message: 'Pedido no encontrado con ID: $id',
          statusCode: 404,
          error: response.data,
        );
      } else {
        throw ApiException(
          message: 'Error al actualizar el pedido',
          statusCode: response.statusCode ?? 0,
          error: response.data,
        );
      }
    } on DioException catch (e) {
      throw _dioClient._handleDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'Error inesperado al actualizar pedido: ${e.toString()}',
        statusCode: 0,
        error: e,
      );
    }
  }

  @override
  Future<void> deleteOrder(String id) async {
    if (id.isEmpty) {
      throw ApiException(
        message: 'El ID del pedido no puede estar vacío',
        statusCode: 400,
        error: null,
      );
    }
    
    try {
      final url = ApiConstants.getDeleteOrderUrl(id);
      final response = await _dioClient.delete(<String, dynamic>{
        'endpoint': url,
        'options': Options(
          headers: ApiConstants.getHeaders(null),
          receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
          sendTimeout: Duration(milliseconds: ApiConstants.sendTimeout),
        ),
      });
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      } else if (response.statusCode == 404) {
        throw ApiException(
          message: 'Pedido no encontrado con ID: $id',
          statusCode: 404,
          error: response.data,
        );
      } else {
        throw ApiException(
          message: 'Error al eliminar el pedido',
          statusCode: response.statusCode ?? 0,
          error: response.data,
        );
      }
    } on DioException catch (e) {
      throw _dioClient._handleDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: 'Error inesperado al eliminar pedido: ${e.toString()}',
        statusCode: 0,
        error: e,
      );
    }
  }
}

// === ARCHIVO: client/lib/presentation/screens/orders_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../widgets/order_card.dart';
import '../widgets/loading_indicator.dart';
import '../../core/constants/app_colors.dart';
import 'order_detail_screen.dart';
import 'create_order_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersViewModel()..loadOrders(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            'Mis Pedidos',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.onPrimary),
              onPressed: () {
                context.read<OrdersViewModel>().loadOrders();
              },
            ),
          ],
        ),
        body: BlocBuilder<OrdersViewModel, OrdersState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingIndicator();
            }

            if (state.error != null) {
              return _buildErrorView(context, state.error!);
            }

            if (state.orders.isEmpty) {
              return _buildEmptyView(context);
            }

            return _buildOrdersList(context, state.orders);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _navigateToCreateOrder(context),
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          icon: const Icon(Icons.add),
          label: const Text('Nuevo Pedido'),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar pedidos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<OrdersViewModel>().loadOrders();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay pedidos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aún no has realizado ningún pedido.\n¡Crea tu primer pedido ahora!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _navigateToCreateOrder(context),
              icon: const Icon(Icons.add),
              label: const Text('Crear Pedido'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: AppColors.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OrdersViewModel>().loadOrders();
      },
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: OrderCard(
              order: order,
              onTap: () => _navigateToOrderDetail(context, order.id),
            ),
          );
        },
      ),
    );
  }

  void _navigateToOrderDetail(BuildContext context, String orderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(orderId: orderId),
      ),
    ).then((_) {
      context.read<OrdersViewModel>().loadOrders();
    });
  }

  void _navigateToCreateOrder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateOrderScreen(),
      ),
    ).then((_) {
      context.read<OrdersViewModel>().loadOrders();
    });
  }
}

// === ARCHIVO: client/lib/presentation/screens/order_detail_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/app_colors.dart';
import 'package:get_it/get_it.dart';
import '../widgets/loading_indicator.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late final OrderRepositoryImpl _repository;
  bool _isLoading = true;
  Order? _order;
  String? _error;

  @override
  void initState() {
    super.initState();
    _repository = OrderRepositoryImpl(
      OrderRemoteDataSource(GetIt.instance<DioClient>()),
    );
    _loadOrderDetail();
  }

  Future<void> _loadOrderDetail() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final order = await _repository.getOrderById(widget.orderId);
      setState(() {
        _order = order;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Detalle del Pedido',
          style: TextStyle(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.onPrimary),
            onPressed: _loadOrderDetail,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicator();
    }

    if (_error != null) {
      return _buildErrorView();
    }

    if (_order == null) {
      return _buildNotFoundView();
    }

    return _buildOrderDetail();
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar detalle',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadOrderDetail,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFoundView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Pedido no encontrado',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 24),
          _buildStatusSection(),
          const SizedBox(height: 24),
          _buildItemsSection(),
          const SizedBox(height: 24),
          _buildTotalSection(),
          const SizedBox(height: 24),
          _buildActionsSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pedido #${_order!.id}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  _formatDate(_order!.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Cliente: ${_order!.customerName}',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              'Email: ${_order!.customerEmail}',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estado del Pedido',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _getStatusColor(_order!.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _order!.status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsSection() {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Artículos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            ..._order!.items.map((item) => _buildItemRow(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  'Cantidad: ${item.quantity}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              '\$${_order!.total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _showCancelDialog(),
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Cancelar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: BorderSide(color: AppColors.error),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showUpdateStatusDialog(),
            icon: const Icon(Icons.update),
            label: const Text('Actualizar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Pedido'),
        content: const Text(
          '¿Estás seguro de que deseas cancelar este pedido?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _cancelOrder();
            },
            child: Text(
              'Sí, cancelar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelOrder() async {
    try {
      await _repository.updateOrder(
        widget.orderId,
        {'status': 'cancelled'},
      );
      _loadOrderDetail();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cancelar: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showUpdateStatusDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Actualizar Estado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusOption('pending', 'Pendiente'),
            _buildStatusOption('processing', 'Procesando'),
            _buildStatusOption('shipped', 'Enviado'),
            _buildStatusOption('delivered', 'Entregado'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(String status, String label) {
    return ListTile(
      title: Text(label),
      onTap: () async {
        Navigator.pop(context);
        await _updateStatus(status);
      },
    );
  }

  Future<void> _updateStatus(String status) async {
    try {
      await _repository.updateOrder(
        widget.orderId,
        {'status': status},
      );
      _loadOrderDetail();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Estado actualizado correctamente'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// === ARCHIVO: client/lib/presentation/screens/create_order_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/order_item.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../core/network/api_client.dart';
import '../../core/constants/app_colors.dart';
import 'package:get_it/get_it.dart';
import '../widgets/loading_indicator.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final List<_OrderItemEntry> _items = [];
  bool _isSubmitting = false;
  late final OrderRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    _repository = OrderRepositoryImpl(
      OrderRemoteDataSource(GetIt.instance<DioClient>()),
    );
    _addEmptyItem();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _addEmptyItem() {
    setState(() {
      _items.add(_OrderItemEntry(
        productNameController: TextEditingController(),
        quantityController: TextEditingController(text: '1'),
        priceController: TextEditingController(),
      ));
    });
  }

  void _removeItem(int index) {
    if (_items.length > 1) {
      setState(() {
        _items[index].dispose();
        _items.removeAt(index);
      });
    }
  }

  double get _total {
    double sum = 0;
    for (final item in _items) {
      final quantity = int.tryParse(item.quantityController.text) ?? 0;
      final price = double.tryParse(item.priceController.text) ?? 0;
      sum += quantity * price;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Crear Pedido',
          style: TextStyle(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isSubmitting
          ? const LoadingIndicator()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCustomerSection(),
                    const SizedBox(height: 24),
                    _buildItemsSection(),
                    const SizedBox(height: 24),
                    _buildTotalSection(),
                    const SizedBox(height: 32),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCustomerSection() {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Datos del Cliente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: _buildInputDecoration(
                'Nombre completo',
                Icons.person_outline,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: _buildInputDecoration(
                'Correo electrónico',
                Icons.email_outlined,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu correo';
                }
                if (!value.contains('@')) {
                  return 'Por favor ingresa un correo válido';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: _buildInputDecoration(
                'Teléfono',
                Icons.phone_outlined,
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu teléfono';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: _buildInputDecoration(
                'Dirección de entrega',
                Icons.location_on_outlined,
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la dirección';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsSection() {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Artículos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                TextButton.icon(
                  onPressed: _addEmptyItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(_items.length, (index) => _buildItemRow(index)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(int index) {
    final item = _items[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: item.productNameController,
                  decoration: const InputDecoration(
                    labelText: 'Producto',
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
              if (_items.length > 1)
                IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: AppColors.error),
                  onPressed: () => _removeItem(index),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: item.quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Cantidad',
                    isDense: true,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: item.priceController,
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                    prefixText: '\$ ',
                    isDense: true,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Requerido';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Card(
      elevation: 2,
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              '\$${_total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _submitOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Crear Pedido',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.error),
      ),
    );
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final items = _items.map((item) {
      return OrderItem(
        id: '',
        productName: item.productNameController.text,
        quantity: int.parse(item.quantityController.text),
        price: double.parse(item.priceController.text),
      );
    }).toList();

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _repository.createOrder(
        customerName: _nameController.text,
        customerEmail: _emailController.text,
        customerPhone: _phoneController.text,
        deliveryAddress: _addressController.text,
        items: items,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pedido creado correctamente'),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al crear pedido: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}

class _OrderItemEntry {
  final TextEditingController productNameController;
  final TextEditingController quantityController;
  final TextEditingController priceController;

  _OrderItemEntry({
    required this.productNameController,
    required this.quantityController,
    required this.priceController,
  });

  void dispose() {
    productNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }
}

// === ARCHIVO: client/lib/presentation/viewmodels/orders_viewmodel.dart ===
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

enum OrdersViewState { initial, loading, loaded, error }

class OrdersState extends Equatable {
  final OrdersViewState viewState;
  final List<Order> orders;
  final String? errorMessage;
  final Order? selectedOrder;
  final bool isCreatingOrder;
  final bool isUpdatingOrder;
  final bool isDeletingOrder;

  const OrdersState({
    this.viewState = OrdersViewState.initial,
    this.orders = const [],
    this.errorMessage,
    this.selectedOrder,
    this.isCreatingOrder = false,
    this.isUpdatingOrder = false,
    this.isDeletingOrder = false,
  });

  OrdersState copyWith({
    OrdersViewState? viewState,
    List<Order>? orders,
    String? errorMessage,
    Order? selectedOrder,
    bool? isCreatingOrder,
    bool? isUpdatingOrder,
    bool? isDeletingOrder,
  }) {
    return OrdersState(
      viewState: viewState ?? this.viewState,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      isUpdatingOrder: isUpdatingOrder ?? this.isUpdatingOrder,
      isDeletingOrder: isDeletingOrder ?? this.isDeletingOrder,
    );
  }

  @override
  List<Object?> get props => [
        viewState,
        orders,
        errorMessage,
        selectedOrder,
        isCreatingOrder,
        isUpdatingOrder,
        isDeletingOrder,
      ];
}

class OrdersViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;

  OrdersState _state = const OrdersState();
  OrdersState get state => _state;

  OrdersViewModel(this._orderRepository);

  Future<void> loadOrders() async {
    _state = _state.copyWith(viewState: OrdersViewState.loading);
    notifyListeners();

    try {
      final orders = await _orderRepository.getOrders();
      _state = _state.copyWith(
        viewState: OrdersViewState.loaded,
        orders: orders,
        errorMessage: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        viewState: OrdersViewState.error,
        errorMessage: _extractErrorMessage(e),
      );
    }
    notifyListeners();
  }

  Future<void> loadOrderById(String orderId) async {
    _state = _state.copyWith(viewState: OrdersViewState.loading);
    notifyListeners();

    try {
      final order = await _orderRepository.getOrderById(orderId);
      _state = _state.copyWith(
        viewState: OrdersViewState.loaded,
        selectedOrder: order,
        errorMessage: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        viewState: OrdersViewState.error,
        errorMessage: _extractErrorMessage(e),
      );
    }
    notifyListeners();
  }

  Future<bool> createOrder(Order order) async {
    _state = _state.copyWith(isCreatingOrder: true);
    notifyListeners();

    try {
      final createdOrder = await _orderRepository.createOrder(order);
      final updatedOrders = [..._state.orders, createdOrder];
      _state = _state.copyWith(
        orders: updatedOrders,
        isCreatingOrder: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _state = _state.copyWith(
        isCreatingOrder: false,
        errorMessage: _extractErrorMessage(e),
      );
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateOrder(Order order) async {
    _state = _state.copyWith(isUpdatingOrder: true);
    notifyListeners();

    try {
      final updatedOrder = await _orderRepository.updateOrder(order);
      final updatedOrders = _state.orders.map((o) {
        return o.id == updatedOrder.id ? updatedOrder : o;
      }).toList();
      _state = _state.copyWith(
        orders: updatedOrders,
        selectedOrder: updatedOrder,
        isUpdatingOrder: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _state = _state.copyWith(
        isUpdatingOrder: false,
        errorMessage: _extractErrorMessage(e),
      );
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    _state = _state.copyWith(isDeletingOrder: true);
    notifyListeners();

    try {
      await _orderRepository.deleteOrder(orderId);
      final updatedOrders =
          _state.orders.where((o) => o.id != orderId).toList();
      _state = _state.copyWith(
        orders: updatedOrders,
        isDeletingOrder: false,
        errorMessage: null,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _state = _state.copyWith(
        isDeletingOrder: false,
        errorMessage: _extractErrorMessage(e),
      );
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _state = _state.copyWith(errorMessage: null);
    notifyListeners();
  }

  void clearSelectedOrder() {
    _state = _state.copyWith(selectedOrder: null);
    notifyListeners();
  }

  String _extractErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'Error de conexión. Verifica tu conexión a internet.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'La solicitud tardó demasiado. Intenta de nuevo.';
    } else if (error.toString().contains('UnauthorizedException')) {
      return 'Sesión expirada. Inicia sesión nuevamente.';
    } else if (error.toString().contains('ForbiddenException')) {
      return 'No tienes permiso para realizar esta acción.';
    } else if (error.toString().contains('NotFoundException')) {
      return 'Recurso no encontrado.';
    } else if (error.toString().contains('ApiException')) {
      final messageMatch =
          RegExp(r'message:\s*"?([^"]+)"?').firstMatch(error.toString());
      return messageMatch?.group(1) ?? 'Error en la operación. Intenta de nuevo.';
    }
    return 'Ocurrió un error inesperado. Intenta de nuevo.';
  }

  List<Order> get filteredOrders {
    return _state.orders;
  }

  double get totalOrdersAmount {
    return _state.orders.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  int get pendingOrdersCount {
    return _state.orders.where((o) => o.status == 'pendiente').length;
  }

  int get completedOrdersCount {
    return _state.orders.where((o) => o.status == 'completado').length;
  }
}

// === ARCHIVO: client/lib/presentation/widgets/order_card.dart ===
import 'package:flutter/material.dart';
import 'package:pedidos_app/core/constants/app_colors.dart';
import 'package:pedidos_app/domain/entities/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onUpdateStatus;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onDelete,
    this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 12),
              _buildStatusBadge(context),
              const SizedBox(height: 12),
              _buildItemsSummary(context),
              const Divider(height: 24),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido #${order.id.substring(0, 8).toUpperCase()}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(order.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurface.withValues(alpha: 0.6),
                    ),
              ),
            ],
          ),
        ),
        if (onDelete != null || onUpdateStatus != null)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.onSurface),
            onSelected: (value) {
              if (value == 'delete' && onDelete != null) {
                onDelete!();
              } else if (value == 'update' && onUpdateStatus != null) {
                onUpdateStatus!();
              }
            },
            itemBuilder: (context) => [
              if (onUpdateStatus != null)
                const PopupMenuItem(
                  value: 'update',
                  child: Row(
                    children: [
                      Icon(Icons.update, size: 20),
                      SizedBox(width: 8),
                      Text('Actualizar estado'),
                    ],
                  ),
                ),
              if (onDelete != null)
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Eliminar', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final statusLabel = _getStatusLabel(order.status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            statusLabel,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSummary(BuildContext context) {
    final itemCount = order.items.length;
    final totalItems = order.items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Row(
      children: [
        Icon(
          Icons.shopping_bag_outlined,
          size: 20,
          color: AppColors.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 8),
        Text(
          '$itemCount ${itemCount == 1 ? "producto" : "productos"} ($totalItems unidades)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurface.withValues(alpha: 0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (order.shippingAddress != null && order.shippingAddress!.isNotEmpty)
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.onSurface.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    order.shippingAddress!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurface.withValues(alpha: 0.5),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        const Spacer(),
        Text(
          '\$${order.totalAmount.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
      ],
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.teal;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }

  String _getStatusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.processing:
        return 'Procesando';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

// === ARCHIVO: client/lib/presentation/widgets/loading_indicator.dart ===
import 'package:flutter/material.dart';
import 'package:pedidos_app/core/constants/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;
  final bool showOverlay;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 40.0,
    this.color,
    this.showOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurface.withValues(alpha: 0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );

    if (showOverlay) {
      return Container(
        color: AppColors.inverseSurface.withValues(alpha: 0.5),
        child: content,
      );
    }

    return content;
  }
}

class FullScreenLoading extends StatelessWidget {
  final String? message;

  const FullScreenLoading({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LoadingIndicator(
        message: message ?? 'Cargando...',
        size: 48,
        showOverlay: false,
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: AppColors.inverseSurface.withValues(alpha: 0.3),
              child: LoadingIndicator(
                message: message,
                size: 36,
                showOverlay: true,
              ),
            ),
          ),
      ],
    );
  }
}

class LoadingButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final ButtonStyle? style;

  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.style,
  });

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: widget.style,
      child: widget.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : widget.child,
    );
  }
}

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Permisos de red requeridos para la comunicación con la API -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    
    <!-- Permiso para mantener la conexión activa en segundo plano -->
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
    
    <application
        android:label="Pedidos App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:enableOnBackInvokedCallback="true">
        
        <!-- Configuración de actividad principal -->
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize"
            android:usesCleartextTraffic="false">
            <!-- Especifica que esta actividad puede ser lanzada como launcher principal -->
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme"/>
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <!-- Servicio para notificaciones en segundo plano -->
        <service
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
            android:exported="false"/>
        <service
            android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
            android:exported="false">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON"/>
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </service>
        
        <!-- Configuración de Flutter -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2"/>
        
        <!-- Configuración de seguridad para conexiones HTTPS -->
        <meta-data
            android:name="android.webkit.WebView.EnableSafeBrowsing"
            android:value="true"/>
    </application>
    
    <!-- Declaraciones de consultas para Android 11+ -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: client/ios/Runner/Info.plist ===
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<!-- Configuración de la aplicación -->
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleDisplayName</key>
	<string>Pedidos</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>pedidos_app</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	
	<!-- Permisos de red y conectividad -->
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<false/>
		<key>NSAllowsLocalNetworking</key>
		<true/>
		<key>NSExceptionDomains</key>
		<dict>
			<key>pedidos.example.com</key>
			<dict>
				<key>NSExceptionAllowsInsecureHTTPLoads</key>
				<false/>
				<key>NSExceptionMinimumTLSVersion</key>
				<string>TLSv1.2</string>
				<key>NSExceptionRequiresForwardSecrecy</key>
				<true/>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSPinnedDomains</key>
				<dict>
					<key>api.pedidos.example.com</key>
					<dict>
						<key>NSExceptionAllowsInsecureHTTPLoads</key>
						<false/>
						<key>NSExceptionMinimumTLSVersion</key>
						<string>TLSv1.2</string>
						<key>NSExceptionRequiresForwardSecrecy</key>
						<true/>
						<key>NSIncludesSubdomains</key>
						<true/>
					</dict>
				</dict>
			</dict>
		</dict>
	</dict>
	<key>UIRequiresPersistentWiFi</key>
	<false/>
	<key>UIStatusBarStyle</key>
	<string>UIStatusBarStyleDefault</string>
	<key>UIViewControllerBasedStatusBarAppearance</key>
	<false/>
	
	<!-- Configuración de Flutter -->
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	
	<!-- Capacidades de fondo -->
	<key>UIBackgroundModes</key>
	<array>
		<string>fetch</string>
		<string>remote-notification</string>
	</array>
	
	<!-- Permisos de ubicación (opcional para funciones de entrega) -->
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>Esta aplicación necesita acceso a tu ubicación para mostrar restaurantes cercanos y rastrear tu pedido.</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>Esta aplicación necesita acceso a tu ubicación para notifyarte cuando tu pedido esté cerca.</string>
	
	<!-- Permisos de cámara (opcional para escanear códigos) -->
	<key>NSCameraUsageDescription</key>
	<string>Esta aplicación necesita acceso a la cámara para escanear códigos QR de productos.</string>
	
	<!-- Permisos de photo library (opcional para subir fotos) -->
	<key>NSPhotoLibraryUsageDescription</key>
	<string>Esta aplicación necesita acceso a tus fotos para subir imágenes de productos.</string>
	
	<!-- Configuración de bitcode (requerido para builds de Firebase) -->
	<key>ENABLE_BITCODE</key>
	<false/>
</dict>
</plist>
```
