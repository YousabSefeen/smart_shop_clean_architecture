import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../controller/app_settings_cubit.dart';

class LanguageChangeButton extends StatelessWidget {
  const LanguageChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    ThemeData theme = Theme.of(context);

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
            backgroundColor: theme.secondaryHeaderColor,
            child: Icon(
              Icons.format_color_text_outlined,
              color: theme.scaffoldBackgroundColor,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'language'.translate(context),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const Spacer(),
          DropdownButton(
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
        ],
      ),
    );
  }
}
