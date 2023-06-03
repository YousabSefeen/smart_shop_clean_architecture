import 'package:shop_app_clean_architecture/core/services/service%20locator/categories_service_locator.dart';
import 'package:shop_app_clean_architecture/core/services/service%20locator/home_service_locator.dart';
import 'package:shop_app_clean_architecture/core/services/service%20locator/search_service_locator.dart';

import 'service locator/auth_service_locator.dart';
import 'service locator/cart_service_locator.dart';
import 'service locator/favorite_service_locator.dart';

class InitializeServicesLocators {
  void init() {
    HomeServiceLocator().init();
    CategoriesServiceLocator().init();
    SearchServiceLocator().init();
    FavoriteServiceLocator().init();
    ProfileServiceLocator().init();
    CartServiceLocator().init();
  }
}
