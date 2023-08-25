import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/loading_horizontal_list_view_item.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/common presentation/widgets/custom_cached_network_image.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../global widgets/an_error_widget.dart';
import '../../../domain/entities/categories.dart';
import '../../controller/cubit/categories_cubit.dart';
import '../../controller/states/categories_states.dart';
import '../screens/categories_screen.dart';
import '../screens/category_products_screen.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
      switch (state.categoriesState) {
        case RequestState.loading:
          return const LoadingHorizontalListView();
        case RequestState.loaded:
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'collections'.translate(context),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    InkWell(
                      onTap: () => AppRouters.go(
                        context: context,
                        route: CategoriesScreen.route,
                        arguments: state.categories,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'seeMore'.translate(context),
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.blue,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.blue,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.categories.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Categories category = state.categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15.r),
                        splashColor:Theme.of(context).appBarTheme.backgroundColor,
                        onTap: () => AppRouters.go(
                            context: context,
                            route: CategoryProductsScreen.route,
                            arguments: {
                              'name': category.name,
                              'id': category.id,
                            }),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CustomCachedNetworkImage(
                                  imageUrl: category.imageUrl,
                                  height: 100,
                                  width: 150,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: Text(
                                category.name,
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );

        case RequestState.error:
          return const AnErrorWidget();
      }
    });
  }
}
