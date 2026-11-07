import 'package:equatable/equatable.dart';

/// Entidad que representa un pedido en el dominio de la aplicación.
/// Contiene la información esencial de un pedido y sus líneas de pedido.
class Order extends Equatable {
  final String id;
  final DateTime date;
  final String status;
  final List<OrderItem> items;
  final double total;
  final String customerId;
  final String? description;
  final String paymentMethod;
  final String deliveryAddress;
  final DateTime? deliveryDate;
  final String? trackingNumber;

  const Order({
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

  /// Calcula el total del pedido sumando los subtotales de todos los items
  double get calculatedTotal => items.fold(0.0, (sum, item) => sum + item.subtotal);

  /// Verifica si el pedido está completo
  bool get isCompleted => status == 'completed';

  /// Verifica si el pedido está en proceso
  bool get isProcessing => status == 'processing';

  /// Verifica si el pedido fue cancelado
  bool get isCancelled => status == 'cancelled';

  /// Crea una copia del pedido con los valores modificados
  Order copyWith({
    String? id,
    DateTime? date,
    String? status,
    List<OrderItem>? items,
    double? total,
    String? customerId,
    String? description,
    String? paymentMethod,
    String? deliveryAddress,
    DateTime? deliveryDate,
    String? trackingNumber,
  }) {
    return Order(
      id: id ?? this.id,
      date: date ?? this.date,
      status: status ?? this.status,
      items: items ?? this.items,
      total: total ?? this.total,
      customerId: customerId ?? this.customerId,
      description: description ?? this.description,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      trackingNumber: trackingNumber ?? this.trackingNumber,
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

/// Entidad que representa un ítem dentro de un pedido.
class OrderItem extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double? discount;
  final Map<String, dynamic>? attributes;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.discount,
    this.attributes,
  });

  /// Calcula el subtotal del ítem (precio unitario * cantidad - descuento)
  double get subtotal {
    final discountAmount = discount ?? 0.0;
    return (unitPrice * quantity) - discountAmount;
  }

  /// Verifica si el ítem tiene descuento
  bool get hasDiscount => discount != null && discount! > 0;

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

/// Estados posibles de un pedido
class OrderStatus {
  static const String pending = 'pending';
  static const String processing = 'processing';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const String failed = 'failed';

  static const List<String> values = [
    pending,
    processing,
    completed,
    cancelled,
    failed,
  ];
}

/// Métodos de pago disponibles
class PaymentMethod {
  static const String creditCard = 'credit_card';
  static const String debitCard = 'debit_card';
  static const String cash = 'cash';
  static const String transfer = 'bank_transfer';
  static const String paypal = 'paypal';

  static const List<String> values = [
    creditCard,
    debitCard,
    cash,
    transfer,
    paypal,
  ];
}