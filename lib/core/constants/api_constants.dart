class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://fakestoreapi.com';

  // Authentication
  static const String login = '/auth/login';

  // Products
  static const String products = '/products';
  static const String categories = '/products/categories';

  static String categoryProducts(String category) =>
      '/products/category/$category';

  static String productDetails(int id) => '/products/$id';

  // Users
  static String user(int id) => '/users/$id';
}