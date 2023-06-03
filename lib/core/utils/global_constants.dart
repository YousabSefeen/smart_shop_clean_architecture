import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

//
MediaQueryData queryData =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window);
double width = queryData.size.width;
double height = queryData.size.height;

GetIt sl = GetIt.instance;
String token = '';

///**************************************************************

Locale currentLocale = const Locale("en");
String language = "en";
//  this is default Direction  in first  Start app
//  because the default Current Locale is ("ar")
TextDirection defaultDirection = TextDirection.rtl;

///**************************************************************
Map<int, bool> favorites = {};
Map<int, bool> carts = {};

customSnackBar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        content: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            message,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: message.contains('Add') || message.contains('الإضافة')
            ? Colors.green
            : Colors.red,
        duration: const Duration(milliseconds: 1200),
      ),
    );
}

customToast({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
}) =>
    showToast(message,
        textStyle: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
        context: context,
        backgroundColor: backgroundColor,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
        //const StyledToastPosition(align: Alignment.centerLeft, offset: 50)
        animDuration: const Duration(milliseconds: 900),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ));
