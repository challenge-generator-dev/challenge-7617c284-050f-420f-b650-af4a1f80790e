import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pedido_app/domain/entities/order.dart';
import 'package:pedido_app/domain/repositories/order_repository.dart';
import 'package:pedido_app/presentation/viewmodels/orders_viewmodel.dart';

@GenerateMocks([OrderRepository])
import 'orders_viewmodel_test.mocks.dart';

void main() {
  late OrdersViewModel viewModel;
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
    viewModel = OrdersViewModel(orderRepository: mockOrderRepository);
  });

  group('OrdersViewModel - Carga de pedidos', () {
    test('deberia cargar pedidos exitosamente cuando el repositorio retorna datos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime(2024, 1, 15, 10, 30),
          status: OrderStatus.completed,
          items: [
            const OrderItem(
              productId: 'PROD-001',
              productName: 'Producto de prueba',
              quantity: 2,
              unitPrice: 15.99,
            ),
          ],
          total: 31.98,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Calle Principal 123',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime(2024, 1, 16, 14, 20),
          status: OrderStatus.processing,
          items: [
            const OrderItem(
              productId: 'PROD-002',
              productName: 'Otro producto',
              quantity: 1,
              unitPrice: 25.50,
              discount: 5.00,
            ),
          ],
          total: 20.50,
          customerId: 'CUST-001',
          description: 'Pedido con descuento',
          paymentMethod: PaymentMethod.debitCard,
          deliveryAddress: 'Avenida Secundaria 456',
          deliveryDate: DateTime(2024, 1, 20),
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);

      await viewModel.loadOrders();

      expect(viewModel.orders, equals(orders));
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      verify(mockOrderRepository.getOrders()).called(1);
    });

    test('deberia mantener lista vacia cuando no hay pedidos', () async {
      when(mockOrderRepository.getOrders()).thenAnswer((_) async => []);

      await viewModel.loadOrders();

      expect(viewModel.orders, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
    });

    test('deberia establecer error cuando el repositorio falla', () async {
      when(mockOrderRepository.getOrders()).thenThrow(
        Exception('Error de conexion con el servidor'),
      );

      await viewModel.loadOrders();

      expect(viewModel.orders, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.errorMessage, contains('conexion'));
    });

    test('deberia establecer estado de carga durante la peticion', () async {
      when(mockOrderRepository.getOrders()).thenAnswer(
        (_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return [];
        },
      );

      final future = viewModel.loadOrders();

      expect(viewModel.isLoading, isTrue);

      await future;

      expect(viewModel.isLoading, isFalse);
    });
  });

  group('OrdersViewModel - Creacion de pedidos', () {
    test('deberia crear pedido exitosamente con datos validos', () async {
      final newOrder = Order(
        id: 'ORD-NEW',
        date: DateTime.now(),
        status: OrderStatus.pending,
        items: [
          const OrderItem(
            productId: 'PROD-001',
            productName: 'Producto nuevo',
            quantity: 1,
            unitPrice: 10.00,
          ),
        ],
        total: 10.00,
        customerId: 'CUST-001',
        paymentMethod: PaymentMethod.cash,
        deliveryAddress: 'Nueva direccion 789',
      );

      when(mockOrderRepository.createOrder(any)).thenAnswer((_) async => newOrder);
      when(mockOrderRepository.getOrders()).thenAnswer((_) async => [newOrder]);

      await viewModel.createOrder(
        customerId: 'CUST-001',
        items: newOrder.items,
        paymentMethod: PaymentMethod.cash,
        deliveryAddress: 'Nueva direccion 789',
      );

      expect(viewModel.orders, contains(newOrder));
      verify(mockOrderRepository.createOrder(any)).called(1);
    });

    test('deberia fallar al crear pedido sin items', () async {
      when(mockOrderRepository.createOrder(any)).thenThrow(
        ArgumentError('El pedido debe contener al menos un articulo'),
      );

      expect(
        () => viewModel.createOrder(
          customerId: 'CUST-001',
          items: [],
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion valida',
        ),
        throwsArgumentError,
      );
    });

    test('deberia fallar al crear pedido sin direccion de entrega', () async {
      when(mockOrderRepository.createOrder(any)).thenThrow(
        ArgumentError('La direccion de entrega es obligatoria'),
      );

      expect(
        () => viewModel.createOrder(
          customerId: 'CUST-001',
          items: [
            const OrderItem(
              productId: 'PROD-001',
              productName: 'Producto',
              quantity: 1,
              unitPrice: 10.00,
            ),
          ],
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: '',
        ),
        throwsArgumentError,
      );
    });
  });

  group('OrdersViewModel - Filtrado de pedidos', () {
    test('deberia filtrar pedidos por estado completado', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 2',
        ),
        Order(
          id: 'ORD-003',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 75.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.debitCard,
          deliveryAddress: 'Direccion 3',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final completedOrders = viewModel.getOrdersByStatus(OrderStatus.completed);

      expect(completedOrders.length, equals(2));
      expect(completedOrders.every((o) => o.status == OrderStatus.completed), isTrue);
    });

    test('deberia filtrar pedidos por estado cancelado', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.cancelled,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 2',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final cancelledOrders = viewModel.getOrdersByStatus(OrderStatus.cancelled);

      expect(cancelledOrders.length, equals(1));
      expect(cancelledOrders.first.id, equals('ORD-001'));
    });

    test('deberia retornar lista vacia para estado sin pedidos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final completedOrders = viewModel.getOrdersByStatus(OrderStatus.completed);

      expect(completedOrders, isEmpty);
    });
  });

  group('OrdersViewModel - Busqueda de pedido por ID', () {
    test('deberia encontrar pedido existente por ID', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 2',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final order = viewModel.getOrderById('ORD-002');

      expect(order, isNotNull);
      expect(order!.id, equals('ORD-002'));
      expect(order.status, equals(OrderStatus.pending));
    });

    test('deberia retornar null para ID inexistente', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      final order = viewModel.getOrderById('ORD-INEXISTENTE');

      expect(order, isNull);
    });

    test('deberia buscar pedido antes de cargar pedidos', () {
      final order = viewModel.getOrderById('ORD-001');

      expect(order, isNull);
      verifyNever(mockOrderRepository.getOrders());
    });
  });

  group('OrdersViewModel - Calculo de totales', () {
    test('deberia calcular el total correctamente para multiples pedidos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.50,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
        Order(
          id: 'ORD-002',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 200.75,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.debitCard,
          deliveryAddress: 'Direccion 2',
        ),
        Order(
          id: 'ORD-003',
          date: DateTime.now(),
          status: OrderStatus.pending,
          items: const [],
          total: 50.25,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.cash,
          deliveryAddress: 'Direccion 3',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      expect(viewModel.totalAmount, equals(351.50));
    });

    test('deberia retornar cero cuando no hay pedidos', () async {
      when(mockOrderRepository.getOrders()).thenAnswer((_) async => []);
      await viewModel.loadOrders();

      expect(viewModel.totalAmount, equals(0.0));
    });
  });

  group('OrdersViewModel - Notificacion de cambios', () {
    test('deberia notificar escuchas cuando cambian los pedidos', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);

      var notificacionRecibida = false;
      viewModel.addListener(() {
        notificacionRecibida = true;
      });

      await viewModel.loadOrders();

      expect(notificacionRecibida, isTrue);
    });

    test('deberia remover listener correctamente', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);

      var conteoNotificaciones = 0;
      void listener() => conteoNotificaciones++;

      viewModel.addListener(listener);
      await viewModel.loadOrders();
      viewModel.removeListener(listener);
      await viewModel.loadOrders();

      expect(conteoNotificaciones, equals(1));
    });
  });

  group('OrdersViewModel - Limpieza de estado', () {
    test('deberia limpiar errores al cargar exitosamente', () async {
      when(mockOrderRepository.getOrders()).thenThrow(
        Exception('Primer error'),
      );

      await viewModel.loadOrders();
      expect(viewModel.errorMessage, isNotNull);

      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();

      expect(viewModel.errorMessage, isNull);
    });

    test('deberia limpiar pedidos al llamar clearOrders', () async {
      final orders = [
        Order(
          id: 'ORD-001',
          date: DateTime.now(),
          status: OrderStatus.completed,
          items: const [],
          total: 100.0,
          customerId: 'CUST-001',
          paymentMethod: PaymentMethod.creditCard,
          deliveryAddress: 'Direccion 1',
        ),
      ];

      when(mockOrderRepository.getOrders()).thenAnswer((_) async => orders);
      await viewModel.loadOrders();
      expect(viewModel.orders, isNotEmpty);

      viewModel.clearOrders();

      expect(viewModel.orders, isEmpty);
    });
  });
}