import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/global_constants.dart';
import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../controller/cubit/cart_cubit.dart';

class DecreaseProductButton extends StatelessWidget {
  final int quantity;
  final int uniqueId;

  const DecreaseProductButton({
    required this.quantity,
    required this.uniqueId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeAndLanguageCubit.object(context).theme == ThemeMode.dark;
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 20.w),
      child: CircleAvatar(
        radius: 15.r,
        backgroundColor: isDark ? const Color(0xff52796f) : Colors.black,
        child: IconButton(
          onPressed: () {
            if (quantity == 0) {
              customToast(
                context: context,
                message: 'quantity must be one or more\n from the same product',
                backgroundColor: Colors.red,
              );
            } else {
              CartCubit.object(context).updateCart(
                context: context,
                quantity: quantity - 1,
                productId: uniqueId,
              );

              customToast(
                context: context,
                message: 'The quantity has been\n decreased by one',
                backgroundColor: Colors.red,
              );
            }
          },
          icon: Icon(
            Icons.exposure_minus_1_outlined,
            color: Colors.white,
            size: 18.sp,
          ),
        ),
      ),
    );
  }
}
