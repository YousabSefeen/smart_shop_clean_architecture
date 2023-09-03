import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app settings/controller/app_settings_cubit.dart';
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
