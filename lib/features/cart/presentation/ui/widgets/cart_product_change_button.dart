import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/global_constants.dart';
import '../../controller/cubit/cart_cubit.dart';
import '../../controller/states/cart_states.dart';

class CartProductChangeButton extends StatelessWidget {
  final int productId;

  const CartProductChangeButton({required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            await CartCubit.object(context).changeCart(
              context: context,
              productId: productId,
            );
          },
          icon: Icon(
            carts[productId] ?? false
                ? Icons.shopping_cart
                : Icons.add_shopping_cart_outlined,
            size: 23.sp,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
