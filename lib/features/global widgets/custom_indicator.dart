import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/controller/theme_and_language_cubit.dart';

class CustomIndicator extends StatelessWidget {
  final int index;
  final int length;

  const CustomIndicator({
    required this.index,
    required this.length,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => buildIndicator(index, context),
      ),
    );
  }

  buildIndicator(
    int i,
    BuildContext context,
  ) {
    final isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;
    return index == i
        ? Icon(
            Icons.star,
            color: isDark ? Colors.blue : Colors.deepOrange,
            size: 25.sp,
          )
        : Container(
            height: 15.h,
            width: 15.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey : Colors.black,
              shape: BoxShape.circle,
            ),
          );
  }
}
