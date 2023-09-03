import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_clean_architecture/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:shop_app_clean_architecture/features/favorites/presentation/controller/cubit/favorites_cubit.dart';

import '../../../../features/categories/presentation/controller/cubit/categories_cubit.dart';
import '../../../../features/home data/presentation/controller/cubit/home_cubit.dart';
import '../../global_constants.dart';
import 'app_settings_states.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(AppSettingsInitialStates());

  static AppSettingsCubit object(context) => BlocProvider.of(context);
  ThemeMode theme = ThemeMode.system;

  String textTheme = 'system';

  void changeTheme() async {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;

      textTheme = 'dark';
    } else {
      theme = ThemeMode.light;

      textTheme = 'light';
    }
    emit(ChangeThemeState());
    final pref = await SharedPreferences.getInstance();
    pref.setString('textTheme', textTheme);
  }

  getThemePref() async {
    final pref = await SharedPreferences.getInstance();

    textTheme = pref.getString('textTheme') ?? 'system';

    if (textTheme == 'system') {
      theme = ThemeMode.system;
    } else if (textTheme == 'light') {
      theme = ThemeMode.light;
    } else if (textTheme == 'dark') {
      theme = ThemeMode.dark;
    }

    emit(GetThemeState());
  }

  void onChangeLanguage(String newLanguage, BuildContext context) async {
    language = newLanguage;
    HomeCubit.object(context).getProducts();
    CategoriesCubit.object(context).getCategories();
    CartCubit.object(context).getCart();
    FavoritesCubit.object(context).getFavorites();
    if (language == 'ar') {
      currentLocale = const Locale("ar");
      defaultDirection = TextDirection.rtl;
    } else {
      currentLocale = const Locale("en");
      defaultDirection = TextDirection.ltr;
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('language', language);

    emit(OnChangeLanguageState());
  }

  void getLanguage() async {
    final pref = await SharedPreferences.getInstance();
    language = pref.getString('language') ?? 'en';
    if (language == 'en') {
      currentLocale = const Locale('en');
      defaultDirection = TextDirection.ltr;
    } else {
      currentLocale = const Locale('ar');
      defaultDirection = TextDirection.rtl;
    }
    emit(GetLanguageState());
  }

  bool isInternetConnection = false;
  StreamSubscription? _streamSubscription;

  void checkInternetConnection() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        isInternetConnection = true;
        emit(InternetConnectionState());
      } else {
        emit(NoInternetConnectionState());
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription!.cancel();
    return super.close();
  }
}
