import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.2),
        Icon(
          Icons.star_border_outlined,
          size: height * 0.18,
          color: Theme.of(context).dividerTheme.color,
        ),
        SizedBox(height: height * 0.07),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Text(
            'emptyFavoriteDes'.translate(context),
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 22.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
