import 'package:flutter/foundation.dart';
import 'package:pedido_app/domain/entities/order.dart';
import 'package:pedido_app/domain/repositories/order_repository.dart';
import 'package:pedido_app/core/constants/app_constants.dart';

class OrdersViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 0;

  OrdersViewModel({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isEmpty => _orders.isEmpty && !_isLoading;

  Future<void> loadOrders({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 0;
      _hasMore = true;
      _orders = [];
    }

    if (!_hasMore && !refresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newOrders = await _orderRepository.getOrders(
        page: _currentPage,
        pageSize: AppConstants.ordersPageSize,
      );

      if (newOrders.length < AppConstants.ordersPageSize) {
        _hasMore = false;
      }

      if (refresh) {
        _orders = newOrders;
      } else {
        _orders = [..._orders, ...newOrders];
      }

      _currentPage++;
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreOrders() async {
    if (!_isLoading && _hasMore) {
      await loadOrders();
    }
  }

  Future<bool> createOrder({
    required List<OrderItem> items,
    required String customerId,
    required String paymentMethod,
    required String deliveryAddress,
    String? description,
    DateTime? deliveryDate,
  }) async {
    if (items.length < AppConstants.minOrderItems) {
      _errorMessage = AppConstants.orderFailedMessage;
      notifyListeners();
      return false;
    }

    final total = _calculateTotal(items);
    if (total < AppConstants.minOrderTotal) {
      _errorMessage = AppConstants.orderFailedMessage;
      notifyListeners();
      return false;
    }

    if (description != null && 
        description.length > AppConstants.maxOrderDescriptionLength) {
      _errorMessage = AppConstants.orderFailedMessage;
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final order = Order(
        id: '',
        date: DateTime.now(),
        status: OrderStatus.pending,
        items: items,
        total: total,
        customerId: customerId,
        description: description,
        paymentMethod: paymentMethod,
        deliveryAddress: deliveryAddress,
        deliveryDate: deliveryDate,
      );

      final createdOrder = await _orderRepository.createOrder(order);
      _orders = [createdOrder, ..._orders];
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOrderStatus(String orderId, String newStatus) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedOrder = await _orderRepository.updateOrderStatus(
        orderId, 
        newStatus,
      );

      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _orders[index] = updatedOrder;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshOrders() async {
    await loadOrders(refresh: true);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  double _calculateTotal(List<OrderItem> items) {
    return items.fold(0.0, (sum, item) {
      final itemTotal = item.unitPrice * item.quantity;
      final discount = item.discount ?? 0.0;
      return sum + itemTotal - discount;
    });
  }

  String _mapErrorToMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('TimeoutException')) {
      return AppConstants.networkErrorMessage;
    } else if (error.toString().contains('HttpException')) {
      return AppConstants.serverErrorMessage;
    }
    return AppConstants.unknownErrorMessage;
  }

  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Order> getOrdersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  List<Order> getPendingOrders() {
    return _orders.where((order) => order.isProcessing).toList();
  }

  List<Order> getCompletedOrders() {
    return _orders.where((order) => order.isCompleted).toList();
  }

  double get totalSpent {
    return _orders
        .where((order) => order.isCompleted)
        .fold(0.0, (sum, order) => sum + order.total);
  }
}