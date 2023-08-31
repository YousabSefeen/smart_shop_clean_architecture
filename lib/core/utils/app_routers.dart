import 'package:flutter/cupertino.dart';

import '../../features/authentication/presentation/ui/screens/login_screen.dart';
import '../../features/authentication/presentation/ui/screens/profile_screen.dart';
import '../../features/authentication/presentation/ui/screens/register_screen.dart';
import '../../features/categories/presentation/ui/screens/categories_screen.dart';
import '../../features/categories/presentation/ui/screens/category_products_screen.dart';
import '../../features/home data/presentation/ui/screens/bottom_nav_screen.dart';
import '../../features/home data/presentation/ui/screens/home_screen.dart';
import '../common presentation/screens/no_internet_connection_screen.dart';
import '../common presentation/screens/product_details_screen.dart';

abstract class AppRouters {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.route: (context) => const LoginScreen(),
    BottomNavigationScreen.route: (context) => BottomNavigationScreen(),
    RegisterScreen.route: (context) => const RegisterScreen(),
    HomeScreen.route: (context) => const HomeScreen(),
    ProductDetailsScreen.route: (context) => const ProductDetailsScreen(),
    CategoriesScreen.route: (context) => const CategoriesScreen(),
    CategoryProductsScreen.route: (context) => const CategoryProductsScreen(),
    ProfileScreen.route: (context) => const ProfileScreen(),
    NoInternetConnectionScreen.route: (context) =>
        const NoInternetConnectionScreen(),
  };

  static void go({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) =>
      Navigator.of(context, rootNavigator: true)
          .pushNamed(route, arguments: arguments);

  static void goAndReplacement({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) =>
      Navigator.of(context, rootNavigator: true)
          .pushReplacementNamed(route, arguments: arguments);

  static void goAndRemoveUntil({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) =>
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        route,
        (Route<dynamic> route) => false,
      );

  static pop({
    required BuildContext context,
  }) =>
      Navigator.of(context).pop();
}
