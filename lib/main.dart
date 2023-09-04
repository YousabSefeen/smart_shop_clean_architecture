import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';

import 'core/services/initialize_services_locators.dart';
import 'core/utils/app settings/components/app_localizations.dart';
import 'core/utils/app settings/components/app_themes.dart';
import 'core/utils/app settings/controller/app_settings_cubit.dart';
import 'core/utils/app settings/controller/app_settings_states.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/global_constants.dart';
import 'features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'features/authentication/presentation/ui/screens/login_screen.dart';
import 'features/authentication/presentation/ui/screens/on_boarding_screen.dart';
import 'features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'features/categories/presentation/controller/cubit/categories_cubit.dart';
import 'features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import 'features/home data/presentation/controller/cubit/home_cubit.dart';
import 'features/home data/presentation/ui/screens/bottom_nav_screen.dart';
import 'features/search/presentation/controller/cubit/search_products_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = MyBlocObserver();

  InitializeServicesLocators().init();

  final pref = await SharedPreferences.getInstance();
  token = pref.getString('token') ?? '';

  if (kDebugMode) {
    print('Token= $token}');
  }

  bool isWatchOnBoard = pref.getBool('isWatchOnBoard') ?? false;

  late Widget mainScreen;

  if (isWatchOnBoard) {
    if (token == '') {
      mainScreen = const LoginScreen();
    }
    if (token != '') {
      mainScreen = BottomNavigationScreen();
    }
  } else {
    mainScreen = const OnBoardingScreen();
  }

  runApp(MyApp(mainScreen));
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;

  const MyApp(this.mainScreen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppSettingsCubit>()
            ..getThemePref()
            ..getLanguage()
            ..checkInternetConnection(),
        ),
        BlocProvider(
          create: (context) => sl<HomeCubit>()
            ..getBanners()
            ..getProducts(),
        ),
        BlocProvider(
            create: (context) => sl<CategoriesCubit>()..getCategories()),
        BlocProvider(
          create: (context) => sl<AuthCubit>()..getProfileData(),
        ),
        BlocProvider(create: (context) => sl<FavoritesCubit>()..getFavorites()),
        BlocProvider(create: (context) => sl<SearchProductsCubit>()),
        BlocProvider(create: (context) => sl<CartCubit>()..getCart()),
      ],
      child: BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: currentLocale,
              supportedLocales: const [
                Locale("en"),
                Locale("ar"),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var local in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == local.languageCode) {
                    return deviceLocale;
                  }
                }
                return supportedLocales.first;
              },
              theme: AppThemes.light(currentLocale),
              darkTheme: AppThemes.dark(currentLocale),
              themeMode: AppSettingsCubit.object(context).theme,
              home: mainScreen,
              routes: AppRouters.routes,
            ),
          );
        },
      ),
    );
  }
}
