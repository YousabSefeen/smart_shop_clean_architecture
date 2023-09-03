import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../features/cart/presentation/ui/widgets/cart_product_change_button.dart';
import '../../../features/favorites/presentation/ui/widgets/favorite_product_change_button.dart';
import '../../utils/app_routers.dart';
import '../screens/product_details_screen.dart';
import 'custom_cached_network_image.dart';
import 'show_discount.dart';

class ProductItem extends StatelessWidget {
  final int index;
  final int itemCount;
  final dynamic product;

  const ProductItem({
    required this.index,
    required this.itemCount,
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textContext = Theme.of(context).textTheme;
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: const Duration(milliseconds: 400),
      columnCount: itemCount,
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: InkWell(
            splashColor: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(15.r),
            onTap: () => AppRouters.go(
                context: context,
                route: ProductDetailsScreen.route,
                arguments: product.id),
            child: Card(
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 0.35,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Hero(
                              tag: product.id,
                              child: CustomCachedNetworkImage(
                                imageUrl: product.imageUrl,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          if (product.discount != 0)
                            ShowDiscount(
                              discount: product.discount,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.31,
                            child: Text(
                              product.name,
                              style:
                                  textContext.titleSmall!.copyWith(height: 1.2),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.19,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Chip(
                                  label: Text(
                                    '${product.price.toInt()} ${'eg'.translate(context)} ',
                                    style: textContext.bodyMedium,
                                  ),
                                ),
                                if (product.discount != 0)
                                  Expanded(
                                    child: Text(
                                      '${product.oldPrice.toInt()}',
                                      style: textContext.labelMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CartProductChangeButton(
                                  productId: product.id,
                                ),
                                FavoriteProductChangeButton(
                                  productId: product.id,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
