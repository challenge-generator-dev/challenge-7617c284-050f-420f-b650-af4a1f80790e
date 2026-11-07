import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pedido_app/di/injection.dart';
import 'package:pedido_app/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const PedidoApp());
}

class PedidoApp extends StatelessWidget {
  const PedidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<ProductsViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<OrdersViewModel>()),
      ],
      child: MaterialApp(
        title: 'Pedido App',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// Inicialización de dependencias y configuración de la aplicación
void configureDependencies() {
  try {
    getIt.registerSingleton<ProductsViewModel>(ProductsViewModel(
      productRepository: getIt<ProductRepository>(),
    ));
    getIt.registerSingleton<OrdersViewModel>(OrdersViewModel(
      orderRepository: getIt<OrderRepository>(),
    ));
  } catch (e) {
    throw Exception('Error al configurar dependencias: $e');
  }
}