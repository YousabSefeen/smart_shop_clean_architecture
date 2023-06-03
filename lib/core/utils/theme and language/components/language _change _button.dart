import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../global_constants.dart';
import '../controller/theme_and_language_cubit.dart';

class LanguageChangeButton extends StatelessWidget {
  const LanguageChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.only(top: height * 0.05),
      leading: CircleAvatar(
        radius: 20.r,
        backgroundColor: theme.secondaryHeaderColor,
        child: Icon(
          Icons.format_color_text_outlined,
          color: theme.scaffoldBackgroundColor,
        ),
      ),
      title: Text(
        'language'.translate(context),
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
              //    color: theme.scaffoldBackgroundColor,
              letterSpacing: 1.5,
              fontSize: 18.sp,
            ),
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: theme.secondaryHeaderColor,
          size: 30.sp,
        ),
        underline: const SizedBox(),
        items: [
          DropdownMenuItem(
            value: 'ar',
            child: Text(
              'arabic'.translate(context),
            ),
          ),
          DropdownMenuItem(
            value: 'en',
            child: Text(
              'english'.translate(context),
            ),
          ),
        ],
        onChanged: (newLanguage) {
          ThemeAndLanguageCubit.object(context).onChangeLanguage(
            newLanguage!,
            context,
          );
        },
      ),
    );
  }
}
