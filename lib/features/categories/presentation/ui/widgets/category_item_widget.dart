import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/utils/theme%20and%20language/components/app_localizations.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../../global widgets/an_error_widget.dart';
import '../../../../global widgets/loading_widget.dart';
import '../../../domain/entities/categories.dart';
import '../../controller/cubit/categories_cubit.dart';
import '../../controller/states/categories_states.dart';
import '../screens/categories_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
      switch (state.categoriesState) {
        case RequestState.loading:
          return const LoadingWidgets();
        case RequestState.loaded:
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.h, bottom: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'collections'.translate(context),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.of(context, rootNavigator: true).pushNamed(
                        CategoriesScreen.route,
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
                height: height * 0.17,
                child: ListView.builder(
                  itemCount: state.categories.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    Categories category = state.categories[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(360),
                            child: CachedNetworkImage(
                              imageUrl: category.imageUrl,
                              errorWidget: (context, s, _) =>
                                  Image.asset('assets/images/imageError.png'),
                              placeholder: (context, _) =>
                                  Image.asset('assets/images/loading.gif'),
                              fit: BoxFit.cover,
                              width: width * 0.3,
                              height: height * 0.13,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.3,
                            child: Text(
                              category.name,
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
