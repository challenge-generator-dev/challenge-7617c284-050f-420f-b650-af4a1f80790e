library pedido_app.data.repositories;

import '../../domain/repositories/order_repository.dart';
import '../../domain/entities/order.dart';
import '../datasources/remote/order_remote_datasource.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource _remoteDatasource;
  
  OrderRepositoryImpl({required OrderRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;
  
  @override
  Future<List<Order>> getOrders({int page = 1, int limit = 20}) async {
    final orderModels = await _remoteDatasource.getOrders(page: page, limit: limit);
    return orderModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<Order> getOrderById(String id) async {
    final orderModel = await _remoteDatasource.getOrderById(id);
    return _mapModelToEntity(orderModel);
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    final orderModel = _mapEntityToModel(order);
    final createdModel = await _remoteDatasource.createOrder(orderModel);
    return _mapModelToEntity(createdModel);
  }
  
  @override
  Future<Order> updateOrder(String id, Order order) async {
    final orderModel = _mapEntityToModel(order);
    final updatedModel = await _remoteDatasource.updateOrder(id, orderModel);
    return _mapModelToEntity(updatedModel);
  }
  
  @override
  Future<void> cancelOrder(String id) async {
    await _remoteDatasource.cancelOrder(id);
  }
  
  @override
  Future<List<Order>> getOrdersByStatus(String status, {int page = 1, int limit = 20}) async {
    final orderModels = await _remoteDatasource.getOrdersByStatus(status, page: page, limit: limit);
    return orderModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<List<Order>> getOrdersByCustomer(String customerId, {int page = 1, int limit = 20}) async {
    final orderModels = await _remoteDatasource.getOrdersByCustomer(customerId, page: page, limit: limit);
    return orderModels.map(_mapModelToEntity).toList();
  }
  
  Order _mapModelToEntity(OrderModel model) {
    return Order(
      id: model.id,
      date: model.date,
      status: model.status,
      items: model.items.map((item) => OrderItem(
        productId: item.productId,
        productName: item.productName,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        discount: item.discount,
        attributes: item.attributes,
      )).toList(),
      total: model.total,
      customerId: model.customerId,
      description: model.description,
      paymentMethod: model.paymentMethod,
      deliveryAddress: model.deliveryAddress,
      deliveryDate: model.deliveryDate,
      trackingNumber: model.trackingNumber,
    );
  }
  
  OrderModel _mapEntityToModel(Order entity) {
    return OrderModel(
      id: entity.id,
      date: entity.date,
      status: entity.status,
      items: entity.items.map((item) => OrderItemModel(
        productId: item.productId,
        productName: item.productName,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        discount: item.discount,
        attributes: item.attributes,
      )).toList(),
      total: entity.total,
      customerId: entity.customerId,
      description: entity.description,
      paymentMethod: entity.paymentMethod,
      deliveryAddress: entity.deliveryAddress,
      deliveryDate: entity.deliveryDate,
      trackingNumber: entity.trackingNumber,
    );
  }
}