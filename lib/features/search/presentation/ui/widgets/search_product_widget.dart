import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../cart/presentation/ui/widgets/cart_product_change_button.dart';
import '../../../../favorites/presentation/ui/widgets/favorite_product_change_button.dart';
import '../../../../../core/common presentation/screens/product_details_screen.dart';
import '../../../domain/entities/search_products.dart';

class SearchProductWidget extends StatelessWidget {
  final SearchProducts product;
  final int index;
  final int columnCount;

  const SearchProductWidget({
    required this.product,
    required this.index,
    required this.columnCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textContext = Theme.of(context).textTheme;
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: const Duration(milliseconds: 300),
      columnCount: columnCount,
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: InkWell(
            onTap: () => AppRouters.go(
                context: context,
                route: ProductDetailsScreen.route,
                arguments: product.id),
            child: GridTile(
              footer: Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: ListTile(
                  leading: CartProductChangeButton(
                    productId: product.id,
                  ),
                  trailing: FavoriteProductChangeButton(
                    productId: product.id,
                  ),
                ),
              ),
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
                                tag: index,
                                child: CachedNetworkImage(
                                  imageUrl: product.imageUrl,
                                  errorWidget: (context, s, _) => Image.asset(
                                      'assets/images/imageError.png'),
                                  placeholder: (context, _) =>
                                      Image.asset('assets/images/loading.gif'),
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 3.h),
                              height: constraints.maxHeight * 0.26,
                              child: Text(
                                product.name,
                                style: textContext.titleSmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.21,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Chip(
                                    label: Text(
                                      '${product.price.toInt()} ${'eg'.translate(context)}',
                                      style: textContext.bodyMedium,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
