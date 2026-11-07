/// Constantes globales de la aplicación para evitar valores mágicos en el código.
/// Incluye textos, límites, identificadores y configuraciones comunes.
library pedido_app.constants;

class AppConstants {
  // Límites de datos
  static const int maxProductsPerOrder = 50;
  static const int maxOrderDescriptionLength = 200;
  static const int minOrderItems = 1;
  static const double minOrderTotal = 0.01;

  // Identificadores de rutas
  static const String homeRoute = '/home';
  static const String ordersRoute = '/orders';
  static const String productsRoute = '/products';
  static const String orderDetailRoute = '/order-detail';
  static const String productDetailRoute = '/product-detail';

  // Textos de la aplicación
  static const String appName = 'PedidoApp';
  static const String ordersTitle = 'Mis Pedidos';
  static const String productsTitle = 'Productos';
  static const String orderDetailTitle = 'Detalle de Pedido';
  static const String emptyOrdersMessage = 'No tienes pedidos aún';
  static const String emptyProductsMessage = 'No hay productos disponibles';
  static const String retryButtonText = 'Reintentar';
  static const String errorTitle = 'Error';
  static const String networkErrorMessage = 'No hay conexión a internet';
  static const String serverErrorMessage = 'Error en el servidor';
  static const String unknownErrorMessage = 'Error desconocido';
  static const String orderCreatedMessage = 'Pedido creado con éxito';
  static const String orderFailedMessage = 'No se pudo crear el pedido';

  // Configuración de paginación
  static const int productsPageSize = 10;
  static const int ordersPageSize = 5;

  // Configuración de caché
  static const Duration productsCacheDuration = Duration(minutes: 30);
  static const Duration ordersCacheDuration = Duration(minutes: 15);

  // Configuración de animaciones
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);

  // Configuración de validación
  static final RegExp emailRegex = RegExp(
    r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$',
  );
  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  // Configuración de seguridad
  static const int minPasswordLength = 8;
  static const String biometricAuthKey = 'biometric_auth_pref';
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';

  // Configuración de localización
  static const String defaultLocale = 'es';
  static const List<String> supportedLocales = ['es', 'en'];

  // Configuración de logging
  static const String logTag = 'PedidoApp';
  static const bool enableDebugLogs = true;
}