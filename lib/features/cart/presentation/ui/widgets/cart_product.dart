import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_cached_network_image.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../../../core/utils/app settings/controller/app_settings_cubit.dart';
import '../../../domain/entities/cart_items.dart';
import 'decrease_product_button.dart';
import 'delete_product_from_cart.dart';
import 'increase_product_button.dart';

class CartProduct extends StatelessWidget {
  final CartItems cartItems;
  final int quantity;
  final int uniqueId;

  const CartProduct({
    required this.cartItems,
    required this.quantity,
    required this.uniqueId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    final product = cartItems.productItem!;
    bool isDark = AppSettingsCubit.object(context).theme == ThemeMode.dark;
    TextTheme textContext = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      height: height * 0.18,
      child: Card(
        margin: EdgeInsets.zero,
        child: LayoutBuilder(
          builder: (context, constraints) => Row(
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: CustomCachedNetworkImage(
                    imageUrl: product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.7,
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.02),
                    SizedBox(
                      height: constraints.maxHeight * .35,
                      child: Text(
                        product.name,
                        style: textContext.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.3,
                      child: Row(
                        children: [
                          DecreaseProductButton(
                            quantity: quantity,
                            uniqueId: uniqueId,
                          ),
                          IncreaseProductButton(
                            quantity: quantity,
                            uniqueId: uniqueId,
                          ),
                          const Spacer(),
                          DeleteProductFromCart(
                            productId: product.id,
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * .3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Chip(
                            label: Text(
                              '${product.price.toInt()} ${'eg'.translate(context)}',
                              style: textContext.bodyMedium,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (product.discount != 0)
                            Text(
                              '${product.oldPrice.toInt()}',
                              style: textContext.labelMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                                text: quantity.toString(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color:
                                      isDark ? Colors.white : Colors.blueGrey,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' X',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w800,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.blueGrey,
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
