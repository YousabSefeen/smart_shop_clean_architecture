import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../global_constants.dart';
import '../controller/app_settings_cubit.dart';

class LanguageChangeButton extends StatelessWidget {
  const LanguageChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    ThemeData theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.only(top: height * 0.02),
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
          letterSpacing: language == 'en' ? 1.8 : 0,
            ),
      ),
      trailing: DropdownButton(
        alignment: Alignment.center,
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
            alignment: Alignment.center,
            child: Text(
              'arabic'.translate(context),
            ),
          ),
          DropdownMenuItem(
            value: 'en',
            alignment: Alignment.center,
            child: Text(
              'english'.translate(context),
            ),
          ),
        ],
        onChanged: (newLanguage) {
          AppSettingsCubit.object(context).onChangeLanguage(
            newLanguage!,
            context,
          );
        },
      ),
    );
  }
}
