import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../../global widgets/an_error_widget.dart';
import '../../../../global widgets/loading_widget.dart';
import '../../../domain/entities/category_details.dart';
import '../../../presentation/controller/cubit/categories_cubit.dart';
import '../../../presentation/controller/states/categories_states.dart';
import '../../../presentation/ui/widgets/category_product_details_widget.dart';

class CategoryProductsDetailsScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductsDetailsScreen({
    required this.categoryName,
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textContext = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider.value(
            value: sl<CategoriesCubit>()
              ..getCategoryDetails(categoryId: categoryId),
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              buildWhen: (previous, current) =>
                  previous.categoryDetailsState != current.categoryDetailsState,
              builder: (context, state) {
                switch (state.categoryDetailsState) {
                  case RequestState.loading:
                    return const LoadingWidgets();
                  case RequestState.loaded:
                    return GridView.builder(
                      shrinkWrap: true,

                      /// It is very important that someone else can get me an error

                      physics: const NeverScrollableScrollPhysics(),

                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 20.w),

                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.w,
                        childAspectRatio: 3.w / 4.h,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 10.h,
                      ),
                      itemCount: state.categoryDetails.length,

                      itemBuilder: (ctx, index) {
                        CategoryDetails product = state.categoryDetails[index];
                        return CategoryProductDetailsWidget(
                          index: index,
                          columnCount: state.categoryDetails.length,
                          product: product,
                        );
                      },
                    );
                  case RequestState.error:
                    return const AnErrorWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
