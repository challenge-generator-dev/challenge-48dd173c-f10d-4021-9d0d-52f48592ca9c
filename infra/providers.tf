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