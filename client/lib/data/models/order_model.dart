library pedido_app.data.models;

import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';

class OrderModel extends Equatable {
  final String id;
  final DateTime date;
  final String status;
  final List<OrderItemModel> items;
  final double total;
  final String customerId;
  final String? description;
  final String paymentMethod;
  final String deliveryAddress;
  final DateTime? deliveryDate;
  final String? trackingNumber;

  const OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.total,
    required this.customerId,
    this.description,
    required this.paymentMethod,
    required this.deliveryAddress,
    this.deliveryDate,
    this.trackingNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      customerId: json['customerId'] as String,
      description: json['description'] as String?,
      paymentMethod: json['paymentMethod'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'] as String)
          : null,
      trackingNumber: json['trackingNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'customerId': customerId,
      'description': description,
      'paymentMethod': paymentMethod,
      'deliveryAddress': deliveryAddress,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'trackingNumber': trackingNumber,
    };
  }

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      date: order.date,
      status: order.status,
      items: order.items.map((item) => OrderItemModel.fromEntity(item)).toList(),
      total: order.total,
      customerId: order.customerId,
      description: order.description,
      paymentMethod: order.paymentMethod,
      deliveryAddress: order.deliveryAddress,
      deliveryDate: order.deliveryDate,
      trackingNumber: order.trackingNumber,
    );
  }

  Order toEntity() {
    return Order(
      id: id,
      date: date,
      status: status,
      items: items.map((item) => item.toEntity()).toList(),
      total: total,
      customerId: customerId,
      description: description,
      paymentMethod: paymentMethod,
      deliveryAddress: deliveryAddress,
      deliveryDate: deliveryDate,
      trackingNumber: trackingNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        status,
        items,
        total,
        customerId,
        description,
        paymentMethod,
        deliveryAddress,
        deliveryDate,
        trackingNumber,
      ];
}

class OrderItemModel extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double? discount;
  final Map<String, dynamic>? attributes;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.discount,
    this.attributes,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
      attributes: json['attributes'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'discount': discount,
      'attributes': attributes,
    };
  }

  factory OrderItemModel.fromEntity(OrderItem item) {
    return OrderItemModel(
      productId: item.productId,
      productName: item.productName,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      discount: item.discount,
      attributes: item.attributes,
    );
  }

  OrderItem toEntity() {
    return OrderItem(
      productId: productId,
      productName: productName,
      quantity: quantity,
      unitPrice: unitPrice,
      discount: discount,
      attributes: attributes,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        quantity,
        unitPrice,
        discount,
        attributes,
      ];
}