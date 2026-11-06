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