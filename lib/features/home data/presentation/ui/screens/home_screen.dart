import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/global_constants.dart';
import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../../../categories/presentation/ui/widgets/category_item_widget.dart';
import '../widgets/banners_items.dart';
import '../widgets/products_items_widget.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = ThemeAndLanguageCubit.object(context);
    final isDark = themeCubit.theme == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('smartShop'.translate(context)),
        leading: IconButton(
          onPressed: () => themeCubit.changeTheme(),
          icon: Icon(
            isDark ? Icons.sunny : Icons.dark_mode_rounded,
            color: isDark ? Colors.amber : Colors.black,
            size: 25.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.23,
                  child: const BannersItems(),
                ),
                const CategoryItemWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    'bestSelling'.translate(context),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const ProductItemWidget(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
