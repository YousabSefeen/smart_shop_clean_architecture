import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';

import '../../../../../core/base  use case/base_use_case.dart';
import '../../../../../core/common presentation/widgets/custom_app_alerts.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../../cart/presentation/controller/cubit/cart_cubit.dart';
import '../../../../favorites/presentation/controller/cubit/favorites_cubit.dart';
import '../../../../home data/presentation/controller/cubit/home_cubit.dart';
import '../../../../home data/presentation/ui/screens/bottom_nav_screen.dart';
import '../../../../search/presentation/controller/cubit/search_products_cubit.dart';
import '../../../domain/use cases/get_profile_use_case.dart';
import '../../../domain/use cases/login_use_case.dart';
import '../../../domain/use cases/register_use_case.dart';
import '../../../domain/use cases/update_profile_use_case.dart';
import '../../ui/screens/login_screen.dart';
import '../states/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.registerUseCase,
  }) : super(const AuthStates());

  static AuthCubit object(context) => BlocProvider.of(context);

  FutureOr<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final result = await registerUseCase(
      AuthParameters(
          name: name, email: email, password: password, phone: phone),
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          registerState: RequestState.error,
          registerErrorMessage: l.errorMessage,
        ),
      ),
      (r) {
        emit(
          state.copyWith(register: r, registerState: RequestState.loaded),
        );

        if (r.status) {
          token = r.data!.token;
          pref.setString('token', token);
          AppRouters.goAndReplacement(
              context: context, route: BottomNavigationScreen.route);
          CustomAppAlerts.customToast(
            context: context,
            message: state.register!.message!,
            backgroundColor: Colors.green,
          );
          getProfileData();
        } else {
          CustomAppAlerts.customToast(
            context: context,
            message: state.register!.message!,
            backgroundColor: Colors.red,
          );
        }
      },
    );
  }

  FutureOr<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final result =
        await loginUseCase(AuthParameters(email: email, password: password));

    result.fold(
      (l) => emit(
        state.copyWith(
          loginState: RequestState.error,
          loginErrorMessage: l.errorMessage,
        ),
      ),
      (r) {
        emit(
          state.copyWith(login: r, loginState: RequestState.loaded),
        );

        if (r.status) {
          token = r.data!.token;
          pref.setString('token', token);

          AppRouters.goAndReplacement(
              context: context, route: BottomNavigationScreen.route);
          CustomAppAlerts.customToast(
            context: context,
            message: state.login!.message!,
            backgroundColor: Colors.green,
          );
          getProfileData();
          HomeCubit.object(context).getProducts();
          FavoritesCubit.object(context).getFavorites();
          CartCubit.object(context).getCart();
        } else {
          CustomAppAlerts.customToast(
            context: context,
            message: state.login!.message!,
            backgroundColor: Colors.red,
          );
        }
      },
    );
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  FutureOr<void> getProfileData() async {
    final result = await getProfileUseCase(const NoParameters());

    result.fold(
        (l) => emit(
              state.copyWith(
                profileState: RequestState.error,
                profileErrorMessage: l.errorMessage,
              ),
            ), (r) {
      emit(state.copyWith(
        profileState: RequestState.loaded,
        profile: r,
      ));
      if (token != '') {
        nameController.text = r.data!.name;
        emailController.text = r.data!.email;
        phoneController.text = r.data!.phone;
      }
    });
  }

  FutureOr<void> updateProfileData({
    required String name,
    required String phone,
    required String email,
    required BuildContext context,
  }) async {
    final result = await updateProfileUseCase(
      AuthParameters(name: name, phone: phone, email: email),
    );

    result.fold(
      (l) => emit(state.copyWith(
        updateProfileState: RequestState.error,
        updateProfileErrorMessage: l.errorMessage,
      )),
      (r) {
        emit(state.copyWith(
          updateProfile: r,
          updateProfileState: RequestState.loaded,
        ));
        CustomAppAlerts.customToast(
          context: context,
          message: 'updateDataMessage'.translate(context),
          backgroundColor: Colors.green,
        );
      },
    );
  }

  void logout(BuildContext context) async {
    ///The following code is used to delete the list of search products
    /// when accessing the search page by another user
    SearchProductsCubit.object(context).searchProducts.clear();

    AppRouters.goAndReplacement(context: context, route: LoginScreen.route);

    final pref = await SharedPreferences.getInstance();

    pref.remove('token');
    token = '';

    if (kDebugMode) {
      //This print is to ensure
      // that a value is omitted token
      print(pref.getString('token'));
      print('Token=  $token');
    }
  }
}
