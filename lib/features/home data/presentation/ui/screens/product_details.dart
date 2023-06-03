import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/global_constants.dart';
import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../../../global widgets/custom_indicator.dart';
import '../../../../global widgets/show_discount.dart';
import '../../../domain/entities/products.dart';
import '../../controller/cubit/home_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const route = 'ProductDetailsScreen';
  final int? id;

  const ProductDetailsScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Products product = HomeCubit.object(context)
        .productsDetails
        .firstWhere((product) => product.id == widget.id);

    bool isDark = ThemeAndLanguageCubit.object(context).theme == ThemeMode.dark;

    TextTheme textContext = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 17.sp,
                  ),
                ),
              ),
            ),
            expandedHeight: height * 0.45,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: product.id,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: product.imagesUrl.length,
                        onPageChanged: (newPage) =>
                            setState(() => _currentPage = newPage),
                        itemBuilder: (ctx, index) {
                          return CachedNetworkImage(
                            imageUrl: product.imagesUrl[index],
                            errorWidget: (context, s, _) =>
                                Image.asset('assets/images/imageError.png'),
                            placeholder: (context, _) =>
                                Image.asset('assets/images/loading.gif'),
                            fit: BoxFit.contain,
                            width: double.infinity,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                      child: Center(
                        child: CustomIndicator(
                          index: _currentPage,
                          length: product.imagesUrl.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                  color: isDark ? Colors.white12 : const Color(0xffe85d04),
                  margin: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 15.w,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 7.w,
                    ),
                    child: Column(
                      children: [
                        Text(
                          product.name,
                          style: textContext.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 7.w,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: product.discount != 0 ? 0 : 15.w,
                          ),
                          child: Column(
                            children: [
                              if (product.discount != 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ShowDiscount(discount: product.discount),
                                  ],
                                ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment: product.discount != 0
                                    ? MainAxisAlignment.spaceAround
                                    : MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'price'.translate(context),
                                        style: textContext.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w900),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${product.price.toInt()} ${'eg'.translate(context)}',
                                            style: textContext.bodyMedium!
                                                .copyWith(
                                              color:
                                                  isDark ? null : Colors.black,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  if (product.discount != 0)
                                    RichText(
                                      text: TextSpan(
                                        text: 'oldPrice'.translate(context),
                                        style: textContext.titleSmall!.copyWith(
                                            fontWeight: FontWeight.w900),
                                        children: [
                                          TextSpan(
                                            text: '${product.oldPrice.toInt()}',
                                            style: textContext.labelMedium!
                                                .copyWith(
                                              color: isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'description'.translate(context),
                  style: textContext.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white12 : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDark ? Colors.blue : Colors.black,
                      width: 1,
                    ),
                  ),
                  margin: EdgeInsets.only(
                      top: 7.h, bottom: 50.h, left: 20.w, right: 20.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 7.h, horizontal: 15.w),
                  child: Text(
                    product.description,
                    style: textContext.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
