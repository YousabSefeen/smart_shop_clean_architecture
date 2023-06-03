import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../../cart/presentation/ui/widgets/cart_product_change_button.dart';
import '../../../../favorites/presentation/ui/widgets/favorite_product_change_button.dart';
import '../../../../global widgets/an_error_widget.dart';
import '../../../../global widgets/loading_widget.dart';
import '../../../../global widgets/show_discount.dart';
import '../../../domain/entities/products.dart';
import '../../controller/cubit/home_cubit.dart';
import '../../controller/states/home_states.dart';
import '../screens/product_details.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textContext = Theme.of(context).textTheme;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.productsState) {
          case RequestState.loading:
            return const LoadingWidgets();
          case RequestState.loaded:
            return GridView.builder(
              shrinkWrap: true,

              /// It is very important that someone else can get me an error
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 20.h),

              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.w,
                childAspectRatio: 3.w / 4.h,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: state.products.length,

              itemBuilder: (ctx, index) {
                Products product = state.products[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 800),
                  columnCount: state.products.length,
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailsScreen(id: product.id),
                          ),
                        ),
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Hero(
                                            tag: product.id,
                                            child: CachedNetworkImage(
                                              imageUrl: product.imageUrl,
                                              errorWidget: (context, s, _) =>
                                                  Image.asset(
                                                      'assets/images/imageError.png'),
                                              placeholder: (context, _) =>
                                                  Image.asset(
                                                      'assets/images/loading.gif'),
                                              height: double.infinity,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                    style:
                                                        textContext.labelMedium,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
              },
            );

          case RequestState.error:
            return const AnErrorWidget();
        }
      },
    );
  }
}
