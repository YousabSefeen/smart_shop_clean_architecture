import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/common presentation/widgets/custom_back.dart';
import '../../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../../core/utils/app_routers.dart';
import '../../../domain/entities/categories.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const String route = 'CategoriesScreen';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    final extractCategories =
        ModalRoute.of(context)!.settings.arguments as List<Categories>;
    return Scaffold(
      appBar: AppBar(
        title: Text('collections'.translate(context)),
        leading: const CustomBack(),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: extractCategories.length,
          separatorBuilder: (context, _) => const Divider(),
          itemBuilder: (context, index) {
            Categories category = extractCategories[index];
            return InkWell(
              splashColor: Theme.of(context).appBarTheme.backgroundColor,
              onTap: () => AppRouters.go(
                  context: context,
                  route: CategoryProductsScreen.route,
                  arguments: {
                    'name': category.name,
                    'id': category.id,
                  }),
              child: SizedBox(
                height: height * 0.15,
                child: LayoutBuilder(
                  builder: (context, constraints) => Row(
                    children: [
                      CustomCachedNetworkImage(
                        imageUrl: category.imageUrl,
                        width: constraints.maxWidth * 0.4,
                        height: double.infinity,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          category.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 17.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.1,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
