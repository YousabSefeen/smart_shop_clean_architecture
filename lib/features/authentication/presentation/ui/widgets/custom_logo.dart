import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';
import 'package:shop_app_clean_architecture/core/utils/global_constants.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEnglish = language == 'en';
    return Container(
      transform:
          Matrix4.rotationZ(isEnglish ? -12 * (pi / 180) : 12 * (pi / 180)),
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 35.w),
      margin: EdgeInsets.only(
        bottom: isEnglish ? 5.h : 40.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffdc2f02),
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.white,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Text(
        'smartShop'.translate(context),
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
              fontSize: 33.sp,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 1),
        ),
      ),
    );
  }
}
