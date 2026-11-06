import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel extends Equatable {
  final String id;
  final String orderId;
  final String productId;
  final String productName;
  final String productSku;
  final int quantity;
  final double unitPrice;
  final double discount;
  final double taxAmount;
  final String? productImageUrl;
  final String? variantId;
  final String? variantName;

  const OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productSku,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0.0,
    this.taxAmount = 0.0,
    this.productImageUrl,
    this.variantId,
    this.variantName,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  double get subtotal {
    final baseTotal = unitPrice * quantity;
    final discountAmount = baseTotal * (discount / 100);
    return baseTotal - discountAmount + taxAmount;
  }

  double get effectiveUnitPrice {
    final discountAmount = unitPrice * (discount / 100);
    return unitPrice - discountAmount;
  }

  double get totalDiscount => unitPrice * quantity * (discount / 100);

  OrderItemModel copyWith({
    String? id,
    String? orderId,
    String? productId,
    String? productName,
    String? productSku,
    int? quantity,
    double? unitPrice,
    double? discount,
    double? taxAmount,
    String? productImageUrl,
    String? variantId,
    String? variantName,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSku: productSku ?? this.productSku,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discount: discount ?? this.discount,
      taxAmount: taxAmount ?? this.taxAmount,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
    );
  }

  bool get hasDiscount => discount > 0;
  bool get hasVariant => variantId != null && variantName != null;
  bool get isTaxable => taxAmount > 0;

  @override
  List<Object?> get props => [
        id,
        orderId,
        productId,
        productName,
        productSku,
        quantity,
        unitPrice,
        discount,
        taxAmount,
        productImageUrl,
        variantId,
        variantName,
      ];
}