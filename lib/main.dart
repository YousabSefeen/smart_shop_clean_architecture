import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_clean_architecture/core/utils/check%20internet/no_internet_connection_screen.dart';

import 'core/services/initialize_services_locators.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/check internet/check_internet.dart';
import 'core/utils/global_constants.dart';
import 'core/utils/theme and language/components/app_localizations.dart';
import 'core/utils/theme and language/components/app_themes.dart';
import 'core/utils/theme and language/controller/theme_and_language_cubit.dart';
import 'core/utils/theme and language/controller/theme_and_language_states.dart';
import 'features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'features/authentication/presentation/ui/screens/login_screen.dart';
import 'features/authentication/presentation/ui/screens/on_boarding_screen.dart';
import 'features/authentication/presentation/ui/screens/profile_screen.dart';
import 'features/authentication/presentation/ui/screens/register_screen.dart';
import 'features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'features/categories/presentation/controller/cubit/categories_cubit.dart';
import 'features/categories/presentation/ui/screens/categories_screen.dart';
import 'features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import 'features/home data/presentation/controller/cubit/home_cubit.dart';
import 'features/home data/presentation/ui/screens/bottom_nav_screen.dart';
import 'features/home data/presentation/ui/screens/home_screen.dart';
import 'features/home data/presentation/ui/screens/product_details.dart';
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

class MyApp extends StatefulWidget {
  final Widget mainScreen;

  const MyApp(this.mainScreen, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// The following code is for checking the internet connection
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  late Widget home;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ThemeAndLanguageCubit>()
            ..getThemePref()
            ..getLanguage(),
        ),
        BlocProvider(
          create: (_) => sl<HomeCubit>()
            ..getBanners()
            ..getProducts(),
        ),
        BlocProvider(create: (_) => sl<CategoriesCubit>()..getCategories()),
        BlocProvider(
          create: (context) => sl<AuthCubit>()..getProfileData(),
        ),
        BlocProvider(create: (_) => sl<FavoritesCubit>()..getFavorites()),
        BlocProvider(create: (_) => sl<SearchProductsCubit>()),
        BlocProvider(create: (_) => sl<CartCubit>()..getCart()),
      ],
      child: BlocConsumer<ThemeAndLanguageCubit, ThemeAndLanguageState>(
        listener: (context, state) {},
        builder: (context, state) {
          // The first step should be to check the internet connection
          // and depending on this the screen will appear.
          //Note that this step is useful for making multiple block providers lazy
          // when there is no internet connection
          switch (_source.keys.toList()[0]) {
            case ConnectivityResult.mobile:
              home = widget.mainScreen;
              break;
            case ConnectivityResult.wifi:
              home = widget.mainScreen;
              break;
            case ConnectivityResult.none:
            default:
              home = const NoInternetConnectionScreen();
          }

          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) => MaterialApp(
              useInheritedMediaQuery: true,
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
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              themeMode: ThemeAndLanguageCubit.object(context).theme,
              home: home,
              routes: {
                LoginScreen.route: (context) => const LoginScreen(),
                BottomNavigationScreen.route: (context) =>
                    BottomNavigationScreen(),
                RegisterScreen.route: (context) => const RegisterScreen(),
                HomeScreen.route: (context) => const HomeScreen(),
                ProductDetailsScreen.route: (context) =>
                    const ProductDetailsScreen(),
                CategoriesScreen.route: (context) => const CategoriesScreen(),
                ProfileScreen.route: (context) => const ProfileScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
