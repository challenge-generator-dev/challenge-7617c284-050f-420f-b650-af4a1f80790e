library pedido_app.data.datasources.remote;

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/order_model.dart';
import '../../../core/config/api_config.dart';
import '../../../core/constants/app_constants.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String orderId);
  Future<OrderModel> createOrder(OrderModel order);
  Future<OrderModel> updateOrderStatus(String orderId, String status);
  Future<void> cancelOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  OrderRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<OrderModel>> getOrders() async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}');
      final response = await client
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<List<OrderModel>>(
        response,
        (data) => (data as List<dynamic>)
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    });
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}/$orderId');
      final response = await client
          .get(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<OrderModel>(
        response,
        (data) => OrderModel.fromJson(data as Map<String, dynamic>),
      );
    });
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}');
      final body = jsonEncode(order.toJson());
      final response = await client
          .post(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<OrderModel>(
        response,
        (data) => OrderModel.fromJson(data as Map<String, dynamic>),
      );
    });
  }

  @override
  Future<OrderModel> updateOrderStatus(String orderId, String status) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}/$orderId/status');
      final body = jsonEncode({'status': status});
      final response = await client
          .patch(
            uri,
            headers: _buildHeaders(contentType: 'application/json'),
            body: body,
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<OrderModel>(
        response,
        (data) => OrderModel.fromJson(data as Map<String, dynamic>),
      );
    });
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    return _executeWithRetry(() async {
      final uri = Uri.parse('${ApiConfig.ordersUrl}/$orderId');
      final response = await client
          .delete(
            uri,
            headers: _buildHeaders(),
          )
          .timeout(ApiConfig.defaultTimeout);

      return _handleResponse<void>(
        response,
        (_) => null,
      );
    });
  }

  Map<String, String> _buildHeaders({String contentType = 'application/json'}) {
    return {
      'Content-Type': contentType,
      'Accept': 'application/json',
    };
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic data) parser,
  ) {
    switch (response.statusCode) {
      case 200:
      case 201:
        final data = jsonDecode(response.body);
        return parser(data);
      case 400:
        throw OrderDataSourceException(
          message: 'Solicitud incorrecta',
          statusCode: 400,
        );
      case 401:
        throw OrderDataSourceException(
          message: 'No autorizado',
          statusCode: 401,
        );
      case 403:
        throw OrderDataSourceException(
          message: 'Acceso prohibido',
          statusCode: 403,
        );
      case 404:
        throw OrderDataSourceException(
          message: 'Pedido no encontrado',
          statusCode: 404,
        );
      case 500:
      case 502:
      case 503:
        throw OrderDataSourceException(
          message: 'Error del servidor',
          statusCode: response.statusCode,
        );
      default:
        throw OrderDataSourceException(
          message: 'Error desconocido: ${response.statusCode}',
          statusCode: response.statusCode,
        );
    }
  }

  Future<T> _executeWithRetry<T>(
    Future<T> Function() operation,
  ) async {
    int attempts = 0;
    Duration delay = ApiConfig.retryDelay;
    Exception? lastException;

    while (attempts < ApiConfig.maxRetries) {
      try {
        return await operation();
      } on OrderDataSourceException {
        rethrow;
      } catch (e) {
        lastException = e;
        attempts++;
        if (attempts < ApiConfig.maxRetries) {
          await Future.delayed(delay);
          delay *= 2;
        }
      }
    }

    throw OrderDataSourceException(
      message: 'Error después de ${ApiConfig.maxRetries} intentos: ${lastException?.toString()}',
      statusCode: 0,
    );
  }
}

class OrderDataSourceException implements Exception {
  final String message;
  final int statusCode;

  OrderDataSourceException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => 'OrderDataSourceException: $message (code: $statusCode)';

  bool get isNetworkError => statusCode == 0;
  bool get isNotFound => statusCode == 404;
  bool get isUnauthorized => statusCode == 401;
  bool get isServerError => statusCode >= 500;
}