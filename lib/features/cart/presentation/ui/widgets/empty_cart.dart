import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';


class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.1),
        Icon(
          Icons.add_shopping_cart_outlined,
          size: height * 0.18,
          color: Theme.of(context).dividerTheme.color,
        ),
        SizedBox(height: height * 0.07),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Text(
            'emptyCartDes'.translate(context),
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
