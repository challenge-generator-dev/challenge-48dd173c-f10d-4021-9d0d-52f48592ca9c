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