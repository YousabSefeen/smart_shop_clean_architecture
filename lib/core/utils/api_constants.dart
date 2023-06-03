class ApiConstants {
  static const String baseUrl = 'https://student.valuxapps.com/api/';
  static const String bannersPath = 'home';
  static const String login = 'login';
  static const String register = 'register';
  static const String productsPath = 'home';
  static const String categoriesPath = 'categories';
  static const String favoritesPath = 'favorites';
  static const String searchProductsPath = 'products/search';
  static const String profile = 'profile';
  static const String updateProfile = 'update-profile';
  static const String carts = 'carts';

  static String updateCart(int productId) => 'carts/$productId';

  static String getCategoryDetails(int categoryId) => 'categories/$categoryId';
}
