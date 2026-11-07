import 'package:flutter/foundation.dart';
import 'package:pedido_app/domain/entities/product.dart';
import 'package:pedido_app/domain/repositories/product_repository.dart';
import 'package:pedido_app/core/constants/app_constants.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;
  
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 0;
  String _searchQuery = '';
  String? _selectedCategory;

  ProductsViewModel({required ProductRepository productRepository})
      : _productRepository = productRepository;

  List<Product> get products => _searchQuery.isEmpty && _selectedCategory == null
      ? _products 
      : _filteredProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isEmpty => products.isEmpty && !_isLoading;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;

  Future<void> loadProducts({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 0;
      _hasMore = true;
      _products = [];
      _filteredProducts = [];
    }

    if (!_hasMore && !refresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newProducts = await _productRepository.getProducts(
        page: _currentPage,
        pageSize: AppConstants.productsPageSize,
      );

      if (newProducts.length < AppConstants.productsPageSize) {
        _hasMore = false;
      }

      if (refresh) {
        _products = newProducts;
      } else {
        _products = [..._products, ...newProducts];
      }

      _currentPage++;
      _applyFilters();
    } catch (e) {
      _errorMessage = _mapErrorToMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreProducts() async {
    if (!_isLoading && _hasMore) {
      await loadProducts();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _filteredProducts = [];
    notifyListeners();
  }

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery) ||
          product.description.toLowerCase().contains(_searchQuery);

      final matchesCategory = _selectedCategory == null ||
          product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  Future<void> refreshProducts() async {
    await loadProducts(refresh: true);
  }

  Future<Product?> getProductById(String id) async {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      try {
        return await _productRepository.getProductById(id);
      } catch (e) {
        return null;
      }
    }
  }

  List<Product> getFeaturedProducts() {
    return _products.where((p) => p.isFeatured).toList();
  }

  List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  List<String> get availableCategories {
    final categories = _products.map((p) => p.category).toSet().toList();
    categories.sort();
    return categories;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
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
}