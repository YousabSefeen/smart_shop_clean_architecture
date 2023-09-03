import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

class ShowDiscount extends StatelessWidget {
  final int discount;

  const ShowDiscount({
    required this.discount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      width: 80.w,
      animation: true,
      lineHeight: 20.h,
      animationDuration: 6000,
      percent: discount / 100,
      center: Text(
        ' $discount${'sale'.translate(context)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      progressColor: Colors.red,
      backgroundColor: Colors.amber,
    );
  }
}
