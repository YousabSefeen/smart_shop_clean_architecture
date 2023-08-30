import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/controller/theme_and_language_cubit.dart';

import '../../utils/app_routers.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: isDark ? Colors.white : Colors.black,
        size: 23.sp,
      ),
      onPressed: () => AppRouters.pop(context: context),
    );
  }
}
