import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../core/common presentation/widgets/custom_app_alerts.dart';
import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../controller/cubit/cart_cubit.dart';

class IncreaseProductButton extends StatelessWidget {
  final int quantity;
  final int uniqueId;

  const IncreaseProductButton({
    required this.quantity,
    required this.uniqueId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;
    return CircleAvatar(
      radius: 15.r,
      backgroundColor: isDark ? const Color(0xff52796f) : Colors.black,
      child: IconButton(
        onPressed: () {
          CartCubit.object(context).updateCart(
            context: context,
            quantity: quantity + 1,
            productId: uniqueId,
          );
          CustomAppAlerts.customToast(
            context: context,
            message: 'The quantity has been\n increased by one',
            backgroundColor: Colors.green,
          );
        },
        icon: Icon(
          Icons.plus_one_outlined,
          color: Colors.white,
          size: 18.sp,
        ),
      ),
    );
  }
}
