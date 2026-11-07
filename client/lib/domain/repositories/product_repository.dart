library pedido_app.domain.repositories;

import 'package:pedido_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({
    int? limit,
    int? offset,
    String? category,
    bool? availableOnly,
  });

  Future<Product> getProductById(String productId);

  Future<List<Product>> searchProducts(String query, {int? limit});

  Future<List<Product>> getProductsByCategory(String category, {int? limit, int? offset});

  Future<List<Product>> getFeaturedProducts({int? limit});

  Future<List<Product>> getProductsOnSale({int? limit});

  Future<List<Product>> getRelatedProducts(String productId, {int? limit});

  Future<bool> checkProductAvailability(String productId, int requestedQuantity);

  Future<Map<String, int>> checkBulkAvailability(List<Map<String, dynamic>> items);

  Future<void> updateProductStock(String productId, int newStock);

  Future<List<String>> getAllCategories();
}