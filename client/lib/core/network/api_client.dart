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