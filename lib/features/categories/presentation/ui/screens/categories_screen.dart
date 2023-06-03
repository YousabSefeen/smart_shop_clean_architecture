import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/global_constants.dart';
import '../../../domain/entities/categories.dart';
import 'category_products_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const String route = 'CategoriesScreen';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final extractCategories =
        ModalRoute.of(context)!.settings.arguments as List<Categories>;
    return Scaffold(
      appBar: AppBar(
        title: Text('collections'.translate(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: extractCategories.length,
          separatorBuilder: (ctx, _) => const Divider(),
          itemBuilder: (ctx, index) {
            Categories category = extractCategories[index];
            return InkWell(
              onTap: () {
                if (kDebugMode) {
                  print(category.id);
                }
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CategoryProductsDetailsScreen(
                    categoryName: category.name,
                    categoryId: category.id,
                  ),
                ));
              },
              child: SizedBox(
                height: height * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CachedNetworkImage(
                      imageUrl: category.imageUrl,
                      errorWidget: (context, s, _) =>
                          Image.asset('assets/images/imageError.png'),
                      placeholder: (context, _) =>
                          Image.asset('assets/images/loading.gif'),
                      fit: BoxFit.cover,
                      width: width * 0.4,
                      height: double.infinity,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: width * 0.4,
                            child: Text(
                              category.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 17.sp),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
