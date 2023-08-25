import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../presentation/ui/widgets/custom_background.dart';
import '../../controller/cubit/auth_cubit.dart';
import '../widgets/custom_login_button.dart';
import '../widgets/custom_login_field.dart';

class RegisterScreen extends StatefulWidget {
  static const route = 'RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _globalKer = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _phoneController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isRegister = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final authCubit = AuthCubit.object(context);
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          flexibleSpace: const CustomBackground(),
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const CustomBackground(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.55,
                      width: width * 0.8,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 5.w),
                          child: Form(
                            key: _globalKer,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10.h),
                                CustomLoginField(
                                  controller: _nameController,
                                  hint: 'name'.translate(context),
                                  obscureText: false,
                                  prefixIcon: Icons.person,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'User name can\'t be blank';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                CustomLoginField(
                                  controller: _phoneController,
                                  hint: 'phoneNumber'.translate(context),
                                  obscureText: false,
                                  prefixIcon: Icons.phone,
                                  textInputType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Phone number can\'t be blank';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                CustomLoginField(
                                  controller: _emailController,
                                  hint: 'emailAddress'.translate(context),
                                  obscureText: false,
                                  prefixIcon: Icons.email_outlined,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Email can\'t be blank';
                                    } else if (!value!.contains('@')) {
                                      return 'The email format is incorrect';
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
                                    if (value == '') {
                                      return 'Password can\'t be blank';
                                    } else if (value!.length < 6) {
                                      return 'Password is too short';
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText: !_showPassword,
                                  suffixIcon: _hideAndShowPasswordButton(),
                                ),
                                CustomLoginField(
                                  hint: 'confirmPassword'.translate(context),
                                  prefixIcon: Icons.lock_clock_outlined,
                                  textInputType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'The password must be confirmed again';
                                    } else if (value !=
                                        _passwordController.text) {
                                      return 'password do not match';
                                    } else {
                                      return null;
                                    }
                                  },
                                  obscureText: !_showConfirmPassword,
                                  suffixIcon:
                                      _hideAndShowConfirmPasswordButton(),
                                ),
                                SizedBox(height: 10.h),
                                _isRegister
                                    ? const CircularProgressIndicator()
                                    : CustomLoginButton(
                                        text: 'signUp'.translate(context),
                                        onTap: () async {
                                          if (_globalKer.currentState!
                                              .validate()) {
                                            FocusScope.of(context).unfocus();

                                            setState(() =>
                                                _isRegister = !_isRegister);
                                            await authCubit.register(
                                              name: _nameController.text.trim(),
                                              email:
                                                  _emailController.text.trim(),
                                              password: _passwordController.text
                                                  .trim(),
                                              phone:
                                                  _phoneController.text.trim(),
                                              context: context,
                                            );
                                            setState(() =>
                                                _isRegister = !_isRegister);
                                          }
                                        },
                                      ),
                                KeyboardVisibilityBuilder(
                                  builder: (context, visible) => visible
                                      ? SizedBox(height: height * 0.25)
                                      : const SizedBox(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _hideAndShowPasswordButton() {
    return IconButton(
      onPressed: () => setState(() => _showPassword = !_showPassword),
      icon: Icon(
        _showPassword ? Icons.visibility_off_outlined : Icons.visibility_sharp,
        size: 19.sp,
        color: Colors.blueGrey,
      ),
    );
  }

  IconButton _hideAndShowConfirmPasswordButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _showConfirmPassword = !_showConfirmPassword;
        });
      },
      icon: Icon(
        _showConfirmPassword
            ? Icons.visibility_off_outlined
            : Icons.visibility_sharp,
        size: 19.sp,
        color: Colors.blueGrey,
      ),
    );
  }
}
