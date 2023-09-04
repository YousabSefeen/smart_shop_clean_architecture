import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../global_constants.dart';
import '../controller/app_settings_cubit.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.sizeOf(context).height;
    final themeCubit = AppSettingsCubit.object(context);
    final isDark = themeCubit.theme == ThemeMode.dark;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 15.r,
            backgroundColor: theme.secondaryHeaderColor,
            child: Icon(Icons.color_lens, color: theme.scaffoldBackgroundColor),
          ),
          const SizedBox(width: 12),
          Text(
            'theme'.translate(context),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: language == 'en' ? 1 : 0,
                ),
          ),
          const Spacer(),
          DropdownButton(
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20.r),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 18.sp,
                ),
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Theme.of(context).secondaryHeaderColor,
              size: 30.sp,
            ),
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                value: 'light',
                child: Text(
                  'lightMode'.translate(context),
                ),
              ),
              DropdownMenuItem(
                value: 'dark',
                child: Text(
                  'darkMode'.translate(context),
                ),
              ),
            ],
            onChanged: (newTheme) {
              if (newTheme == 'light' && isDark == false) {
                return;
              } else if (newTheme == 'dark' && isDark == true) {
                return;
              } else {
                themeCubit.changeTheme();
              }
            },
          ),
        ],
      ),
    );
  }
}
