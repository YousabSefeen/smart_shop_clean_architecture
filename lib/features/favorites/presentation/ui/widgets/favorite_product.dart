import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_cached_network_image.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/common presentation/screens/product_details_screen.dart';
import '../../../../../core/common presentation/widgets/show_discount.dart';
import '../../../../../core/utils/app_routers.dart';
import '../../../domain/entities/favorites.dart';
import '../../../presentation/controller/cubit/favorites_cubit.dart';
import '../../../presentation/controller/states/favorites_state.dart';
import '../../../presentation/ui/widgets/favorite_product_change_button.dart';

class FavoriteProduct extends StatelessWidget {
  final Favorites productItemFavorite;

  final int index;

  const FavoriteProduct(
      {required this.productItemFavorite, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    ProductItemFavorite product = productItemFavorite.productItemFavorite!;

    TextTheme textContext = Theme.of(context).textTheme;

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) =>
          previous.changeFavoriteState != current.changeFavoriteState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                child: InkWell(
                  onTap: () => AppRouters.go(
                      context: context,
                      route: ProductDetailsScreen.route,
                      arguments: product.id),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                        side: BorderSide.none),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            CustomCachedNetworkImage(
                              imageUrl: product.imageUrl,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              width: double.infinity,
                            ),
                            if (product.discount != 0)
                              ShowDiscount(discount: product.discount),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            product.name,
                            style: textContext.titleSmall,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Chip(
                                  label: FittedBox(
                                    child: Text(
                                      '${product.price.toInt()} ${'eg'.translate(context)}',
                                      style: textContext.bodyMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if (product.discount != 0)
                                  Text(
                                    '${product.oldPrice.toInt()}',
                                    style: textContext.labelMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                            FavoriteProductChangeButton(productId: product.id)
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
