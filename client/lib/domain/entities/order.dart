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