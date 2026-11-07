library pedido_app.domain.entities;

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String category;
  final int stock;
  final bool isAvailable;
  final double? discountPercentage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;
  final double? rating;
  final int? reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.category,
    required this.stock,
    this.isAvailable = true,
    this.discountPercentage,
    this.createdAt,
    this.updatedAt,
    this.metadata,
    this.rating,
    this.reviewCount,
  });

  double get effectivePrice {
    if (discountPercentage != null && discountPercentage! > 0) {
      return price * (1 - discountPercentage! / 100);
    }
    return price;
  }

  bool get hasDiscount => discountPercentage != null && discountPercentage! > 0;

  bool get isInStock => stock > 0;

  bool get isLowStock => stock > 0 && stock <= 5;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    int? stock,
    bool? isAvailable,
    double? discountPercentage,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
    double? rating,
    int? reviewCount,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      isAvailable: isAvailable ?? this.isAvailable,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        stock,
        isAvailable,
        discountPercentage,
        createdAt,
        updatedAt,
        metadata,
        rating,
        reviewCount,
      ];
}

class ProductCategory {
  static const String food = 'food';
  static const String beverages = 'beverages';
  static const String electronics = 'electronics';
  static const String clothing = 'clothing';
  static const String home = 'home';
  static const String sports = 'sports';
  static const String books = 'books';
  static const String toys = 'toys';
  static const String health = 'health';
  static const String other = 'other';

  static const List<String> all = [
    food,
    beverages,
    electronics,
    clothing,
    home,
    sports,
    books,
    toys,
    health,
    other,
  ];

  static String getDisplayName(String category) {
    switch (category) {
      case food:
        return 'Comida';
      case beverages:
        return 'Bebidas';
      case electronics:
        return 'Electrónica';
      case clothing:
        return 'Ropa';
      case home:
        return 'Hogar';
      case sports:
        return 'Deportes';
      case books:
        return 'Libros';
      case toys:
        return 'Juguetes';
      case health:
        return 'Salud';
      case other:
        return 'Otros';
      default:
        return category;
    }
  }
}