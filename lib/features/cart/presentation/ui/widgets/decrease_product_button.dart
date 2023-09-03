import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../../../core/common presentation/widgets/custom_app_alerts.dart';
import '../../../../../core/utils/app settings/controller/app_settings_cubit.dart';
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
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 45, right: 45),
      child: CircleAvatar(
        radius: 15.r,
        backgroundColor: isDark ? const Color(0xff52796f) : Colors.black,
        child: IconButton(
          onPressed: () {
            if (quantity == 0) {
              CustomAppAlerts.customToast(
                context: context,
                message: 'zeroQuantityAlert'.translate(context),
                backgroundColor: Colors.red,
              );
            } else {
              CartCubit.object(context).updateCart(
                context: context,
                quantity: quantity - 1,
                productId: uniqueId,
              );

              CustomAppAlerts.customToast(
                context: context,
                message: 'decreaseCart'.translate(context),
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
