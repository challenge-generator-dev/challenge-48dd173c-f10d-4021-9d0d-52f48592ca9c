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