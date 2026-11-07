library pedido_app.data.repositories;

import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product.dart';
import '../datasources/remote/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource _remoteDatasource;
  
  ProductRepositoryImpl({required ProductRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;
  
  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 20}) async {
    final productModels = await _remoteDatasource.getProducts(page: page, limit: limit);
    return productModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<Product> getProductById(String id) async {
    final productModel = await _remoteDatasource.getProductById(id);
    return _mapModelToEntity(productModel);
  }
  
  @override
  Future<List<Product>> searchProducts(String query) async {
    final productModels = await _remoteDatasource.searchProducts(query);
    return productModels.map(_mapModelToEntity).toList();
  }
  
  @override
  Future<Product> createProduct(Product product) async {
    final productModel = _mapEntityToModel(product);
    final createdModel = await _remoteDatasource.createProduct(productModel);
    return _mapModelToEntity(createdModel);
  }
  
  @override
  Future<Product> updateProduct(String id, Product product) async {
    final productModel = _mapEntityToModel(product);
    final updatedModel = await _remoteDatasource.updateProduct(id, productModel);
    return _mapModelToEntity(updatedModel);
  }
  
  @override
  Future<void> deleteProduct(String id) async {
    await _remoteDatasource.deleteProduct(id);
  }
  
  Product _mapModelToEntity(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      imageUrl: model.imageUrl,
      category: model.category,
      stock: model.stock,
      isAvailable: model.isAvailable,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
  
  ProductModel _mapEntityToModel(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
      category: entity.category,
      stock: entity.stock,
      isAvailable: entity.isAvailable,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}