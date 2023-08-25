import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLoginField extends StatelessWidget {
  final TextEditingController? controller;

  final String? hint;

  final bool obscureText;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final TextInputType textInputType;

  final String? Function(String?)? validator;
 final  void Function(String)?   onFieldSubmitted;

  const CustomLoginField({
    this.controller,
    required this.hint,
    required this.obscureText,
    required this.prefixIcon,
    required this.textInputType,
    required this.validator,
    this.suffixIcon,
    this.onFieldSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          hintText: hint,
          hintStyle: GoogleFonts.raleway(
            textStyle: TextStyle(
                fontSize: 17.sp,
                color: const Color(0xffe85d04),
                fontWeight: FontWeight.w700),
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: 22.sp,
            color: Colors.black,
          ),
          suffixIcon: suffixIcon,
        ),
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: validator,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.sp,
          fontWeight: FontWeight.w200,
        ),
        cursorColor: const Color(0xff003566),
      ),
    );
  }
}
