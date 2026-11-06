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