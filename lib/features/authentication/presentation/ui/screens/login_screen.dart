import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';
import 'package:shop_app_clean_architecture/features/authentication/presentation/ui/screens/register_screen.dart';
import 'package:shop_app_clean_architecture/features/authentication/presentation/ui/widgets/custom_logo.dart';

import '../../controller/cubit/auth_cubit.dart';
import '../widgets/custom_background.dart';
import '../widgets/custom_login_button.dart';
import '../widgets/custom_login_field.dart';

class LoginScreen extends StatefulWidget {
  static const route = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _globalKer = GlobalKey<FormState>();
  bool _show = false;
  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return KeyboardDismissOnTap(
      child: Scaffold(
          body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const CustomBackground(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomLogo(),
                  SizedBox(
                    height: height * .38,
                    width: width * 0.8,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      margin: EdgeInsets.only(top: 25.h),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Form(
                          key: _globalKer,
                          child: Column(
                            children: [
                              SizedBox(height: 17.h),
                              CustomLoginField(
                                controller: _emailController,
                                hint: 'emailAddress'.translate(context),
                                prefixIcon: Icons.email_rounded,
                                obscureText: false,
                                textInputType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'field email must be not empty';
                                  } else if (!value.contains('@')) {
                                    return 'Invalid Email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              CustomLoginField(
                                controller: _passwordController,
                                hint: 'password'.translate(context),
                                prefixIcon: Icons.lock_clock_outlined,
                                textInputType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 5) {
                                    return 'Password is too short';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: !_show,
                                suffixIcon: _hideAndShowPasswordButton(),
                                onFieldSubmitted: (_)=> _submit(context),
                              ),
                              SizedBox(height: 13.h),
                              _isLogin
                                  ? const CircularProgressIndicator()
                                  : CustomLoginButton(
                                      text: 'login'.translate(context),
                                      onTap: () => _submit(context),
                                    ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Text(
                                      'signUpQuestion'.translate(context),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => AppRouters.go(
                                        context: context,
                                        route: RegisterScreen.route),
                                    child: Text(
                                      'signUp'.translate(context),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: const Color(0xffe85d04),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  KeyboardVisibilityBuilder(
                    builder: (context, visible) => visible
                        ? SizedBox(height: height * 0.3)
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  IconButton _hideAndShowPasswordButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _show = !_show;
        });
      },
      icon: Icon(
        _show ? Icons.visibility_off_outlined : Icons.visibility_sharp,
        size: 19.sp,
        color: Colors.blueGrey,
      ),
    );
  }

  _submit(BuildContext context) async {
    final authCubit = AuthCubit.object(context);
    if (_globalKer.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() => _isLogin = !_isLogin);
      await authCubit.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );
      setState(() => _isLogin = !_isLogin);
    }
  }
}
