import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../controller/app_settings_cubit.dart';

class ThemeChangeButton extends StatelessWidget {
  const ThemeChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.sizeOf(context).height;
    final themeCubit = AppSettingsCubit.object(context);
    final isDark = themeCubit.theme == ThemeMode.dark;

    return ListTile(
      contentPadding: EdgeInsets.only(top: height * 0.05),
      leading: CircleAvatar(
        radius: 20.r,
        backgroundColor: theme.secondaryHeaderColor,
        child: Icon(Icons.color_lens, color: theme.scaffoldBackgroundColor),
      ),
      title: Text(
        'theme'.translate(context),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
      ),
      trailing: DropdownButton(
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              letterSpacing: 1.5,
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
    );
  }
}
