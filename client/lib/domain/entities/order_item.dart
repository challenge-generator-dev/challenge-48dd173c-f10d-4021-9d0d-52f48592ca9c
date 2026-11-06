package domain.entities;

import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final String? imageUrl;
  final String? notes;

  const OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.imageUrl,
    this.notes,
  });

  double get subtotal {
    return quantity * unitPrice;
  }

  bool get isValid {
    return productId.isNotEmpty &&
        productName.isNotEmpty &&
        quantity > 0 &&
        unitPrice >= 0;
  }

  OrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    String? imageUrl,
    String? notes,
  }) {
    return OrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        productName,
        quantity,
        unitPrice,
        imageUrl,
        notes,
      ];
}