library pedido_app.data.datasources.remote;

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import '../../../core/config/api_config.dart';
import '../../../core/constants/app_constants.dart';

class ProductRemoteDatasource {
  final http.Client _client;
  
  ProductRemoteDatasource({http.Client? client}) : _client = client ?? http.Client();
  
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20}) async {
    final uri = Uri.parse(
      '${ApiConfig.productsUrl}?page=$page&limit=$limit',
    );
    
    try {
      final response = await _client.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleListResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<ProductModel> getProductById(String id) async {
    final uri = Uri.parse('${ApiConfig.productsUrl}/$id');
    
    try {
      final response = await _client.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleSingleResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<List<ProductModel>> searchProducts(String query) async {
    final uri = Uri.parse(
      '${ApiConfig.productsUrl}/search?q=${Uri.encodeComponent(query)}',
    );
    
    try {
      final response = await _client.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleListResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<ProductModel> createProduct(ProductModel product) async {
    final uri = Uri.parse(ApiConfig.productsUrl);
    
    try {
      final response = await _client.post(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(product.toJson()),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleSingleResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<ProductModel> updateProduct(String id, ProductModel product) async {
    final uri = Uri.parse('${ApiConfig.productsUrl}/$id');
    
    try {
      final response = await _client.put(
        uri,
        headers: _buildHeaders(),
        body: jsonEncode(product.toJson()),
      ).timeout(ApiConfig.defaultTimeout);
      
      return _handleSingleResponse(response);
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Future<void> deleteProduct(String id) async {
    final uri = Uri.parse('${ApiConfig.productsUrl}/$id');
    
    try {
      final response = await _client.delete(
        uri,
        headers: _buildHeaders(),
      ).timeout(ApiConfig.defaultTimeout);
      
      if (response.statusCode >= 400) {
        throw HttpException('Error al eliminar producto: ${response.statusCode}');
      }
    } catch (e) {
      throw _mapException(e);
    }
  }
  
  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
  
  List<ProductModel> _handleListResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw HttpException('Error HTTP: ${response.statusCode}');
    }
  }
  
  ProductModel _handleSingleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ProductModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw HttpException('Producto no encontrado');
    } else {
      throw HttpException('Error HTTP: ${response.statusCode}');
    }
  }
  
  Exception _mapException(dynamic e) {
    if (e is Exception) return e;
    return Exception('Error desconocido: $e');
  }
  
  void dispose() {
    _client.close();
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  
  @override
  String toString() => message;
}