import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/theme and language/controller/theme_and_language_cubit.dart';
import '../../../../categories/presentation/ui/widgets/categories_list.dart';
import '../widgets/banners_items.dart';
import '../widgets/products_list.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = AppSettingsCubit.object(context);
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BannersItems(),
              const CategoriesList(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  'bestSelling'.translate(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const ProductsList(),
            ],
          ),
        ),
      ),
    );
  }
}
