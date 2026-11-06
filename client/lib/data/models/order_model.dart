import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String deliveryAddress;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? notes;
  final String paymentMethod;
  final String? paymentStatus;
  final String? trackingNumber;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.notes,
    required this.paymentMethod,
    this.paymentStatus,
    this.trackingNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? deliveryAddress,
    List<OrderItemModel>? items,
    double? totalAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    String? paymentMethod,
    String? paymentStatus,
    String? trackingNumber,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      trackingNumber: trackingNumber ?? this.trackingNumber,
    );
  }

  double calculateTotal() {
    if (items.isEmpty) return 0.0;
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  bool get isPending => status.toLowerCase() == 'pending';
  bool get isConfirmed => status.toLowerCase() == 'confirmed';
  bool get isProcessing => status.toLowerCase() == 'processing';
  bool get isShipped => status.toLowerCase() == 'shipped';
  bool get isDelivered => status.toLowerCase() == 'delivered';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

  int get itemCount => items.length;

  int get totalQuantity {
    if (items.isEmpty) return 0;
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        customerEmail,
        customerPhone,
        deliveryAddress,
        items,
        totalAmount,
        status,
        createdAt,
        updatedAt,
        notes,
        paymentMethod,
        paymentStatus,
        trackingNumber,
      ];
}