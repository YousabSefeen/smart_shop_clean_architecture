import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/cart_cubit.dart';

class DeleteProductFromCart extends StatelessWidget {
  final int productId;

  const DeleteProductFromCart({required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 17.r,
      backgroundColor: Colors.red,
      child: IconButton(
        onPressed: () {
          CartCubit.object(context).changeCart(
            context: context,
            productId: productId,
          );
        },
        icon: Icon(
          Icons.delete,
          color: Colors.white,
          size: 20.sp,
        ),
      ),
    );
  }
}
