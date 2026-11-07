library pedido_app.domain.repositories;

import 'package:pedido_app/domain/entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders({int? limit, int? offset});

  Future<Order> getOrderById(String orderId);

  Future<Order> createOrder({
    required List<OrderItem> items,
    required String customerId,
    required String paymentMethod,
    required String deliveryAddress,
    String? description,
    DateTime? deliveryDate,
  });

  Future<Order> updateOrderStatus({
    required String orderId,
    required String newStatus,
  });

  Future<Order> updateOrder({
    required String orderId,
    List<OrderItem>? items,
    String? paymentMethod,
    String? deliveryAddress,
    String? description,
    DateTime? deliveryDate,
    String? trackingNumber,
  });

  Future<void> cancelOrder(String orderId);

  Future<List<Order>> getOrdersByStatus(String status, {int? limit, int? offset});

  Future<List<Order>> getOrdersByCustomer(String customerId, {int? limit, int? offset});

  Future<String> generateOrderId();

  Future<bool> validateOrderAvailability(List<OrderItem> items);
}