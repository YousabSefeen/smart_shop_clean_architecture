import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/controller/theme_and_language_cubit.dart';

class CustomProfileField extends StatelessWidget {
  final String keyValue;
  final String title;

  final TextEditingController controller;

  final IconData prefixIcon;

  final TextInputType textInputType;

  final String? Function(String?)? validator;

  const CustomProfileField({
    required this.controller,
    required this.title,
    required this.prefixIcon,
    required this.textInputType,
    required this.validator,
    required this.keyValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: TextFormField(
        key: Key(keyValue),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 22.h),
          labelText: title,
          labelStyle: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.blue : const Color(0xffe85d04),
            ),
          ),
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          enabledBorder: _styleBorder(context),
          focusedBorder: _styleBorder(context),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            child: Icon(
              prefixIcon,
              size: 22.sp,
              color: isDark ? Colors.blue : const Color(0xffe85d04),
            ),
          ),
        ),
        keyboardType: textInputType,
        validator: validator,
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            color: isDark ? Colors.white70 : Colors.black,
            fontSize: 17.sp,
          ),
        ),
        cursorColor: Colors.amber,
      ),
    );
  }

  _styleBorder(BuildContext context) {
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide:
          BorderSide(color: isDark ? Colors.grey : Colors.black, width: 2.w),
    );
  }
}
