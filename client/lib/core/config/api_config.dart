/// Configuración centralizada de las URLs y parámetros de la API.
/// Todas las URLs base y endpoints se definen aquí para facilitar su modificación.
library pedido_app.config;

class ApiConfig {
  // URLs base para los diferentes entornos
  static const String _baseUrlDev = 'https://dev-api.pedidosapp.com';
  static const String _baseUrlProd = 'https://api.pedidosapp.com';
  static const String _baseUrlStaging = 'https://staging-api.pedidosapp.com';

  // Endpoints de la API
  static const String ordersEndpoint = '/api/v1/orders';
  static const String productsEndpoint = '/api/v1/products';
  static const String authEndpoint = '/api/v1/auth';
  static const String usersEndpoint = '/api/v1/users';

  // Configuración de timeout y retries
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(milliseconds: 500);

  /// URL base activa según el entorno seleccionado
  static String get baseUrl {
    // En producción se usaría _baseUrlProd, pero para desarrollo usamos staging
    return _baseUrlStaging;
  }

  /// URL completa para el endpoint de órdenes
  static String get ordersUrl => '$baseUrl$ordersEndpoint';

  /// URL completa para el endpoint de productos
  static String get productsUrl => '$baseUrl$productsEndpoint';

  /// URL completa para el endpoint de autenticación
  static String get authUrl => '$baseUrl$authEndpoint';

  /// URL completa para el endpoint de usuarios
  static String get usersUrl => '$baseUrl$usersEndpoint';

  /// Headers por defecto para las peticiones HTTP
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Request-Source': 'mobile',
  };
}