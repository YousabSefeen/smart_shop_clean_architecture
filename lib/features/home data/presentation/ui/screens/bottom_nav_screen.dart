import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';
import 'package:shop_app_clean_architecture/features/home%20data/presentation/ui/screens/setting_screen.dart';

import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../../../cart/presentation/ui/screens/cart_screen.dart';
import '../../../../favorites/presentation/ui/screens/favorites_screen.dart';
import '../../../../search/presentation/ui/screens/search_screen.dart';
import 'home_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  static const route = 'BottomNavigationScreen';

  BottomNavigationScreen({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,

      margin: EdgeInsets.symmetric(horizontal: 5.w),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      stateManagement: true,

      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.r),
        colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const FavoritesScreen(),
      const SearchScreen(),
      const CartScreen(),
      const SettingScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    bool isDark = ThemeAndLanguageCubit.object(context).theme == ThemeMode.dark;
    Color activeColor = isDark ? Colors.blue : const Color(0xfff48c06);

    List<String> listTitles = [
      'home'.translate(context),
      'favorites'.translate(context),
      'search'.translate(context),
      'cart'.translate(context),
      'setting'.translate(context),
    ];
    List<IconData> listIcons = [
      CupertinoIcons.home,
      Icons.star,
      CupertinoIcons.search,
      CupertinoIcons.cart_fill,
      Icons.settings,
    ];
    return List.generate(
      5,
      (index) => PersistentBottomNavBarItem(
        icon: Icon(listIcons[index], color: index == 2 ? Colors.white : null),
        title: (listTitles[index]),
        textStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w800,
        ),
        activeColorPrimary: activeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    );
  }
}
