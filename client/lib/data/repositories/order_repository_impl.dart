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