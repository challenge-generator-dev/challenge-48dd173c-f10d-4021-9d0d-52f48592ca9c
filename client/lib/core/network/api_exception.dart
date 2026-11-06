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