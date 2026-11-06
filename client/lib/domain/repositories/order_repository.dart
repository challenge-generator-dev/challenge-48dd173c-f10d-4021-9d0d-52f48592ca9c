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