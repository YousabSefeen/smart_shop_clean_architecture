import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_error_widget.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/loading_grid_view.dart';

import '../../../../../core/common presentation/widgets/custom_back.dart';
import '../../../../../core/common presentation/widgets/product_item.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../presentation/controller/cubit/categories_cubit.dart';
import '../../../presentation/controller/states/categories_states.dart';

class CategoryProductsScreen extends StatelessWidget {
  static const route = 'CategoryProductsScreen';

  const CategoryProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final extractData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(extractData['name']),
        leading: const CustomBack(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider.value(
            value: sl<CategoriesCubit>()
              ..getCategoryDetails(categoryId: extractData['id']),
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              buildWhen: (previous, current) =>
                  previous.categoryDetailsState != current.categoryDetailsState,
              builder: (context, state) {
                switch (state.categoryDetailsState) {
                  case RequestState.loading:
                    return const LoadingGridView();
                  case RequestState.loaded:
                    return GridView.builder(
                      shrinkWrap: true,

                      /// It is very important that someone else can get me an error

                      physics: const BouncingScrollPhysics(),

                      padding: const EdgeInsets.symmetric(
                          vertical: 23, horizontal: 15),

                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: state.categoryDetails.length,

                      itemBuilder: (ctx, index) {
                        final product = state.categoryDetails[index];

                        return ProductItem(
                          index: index,
                          itemCount: state.categoryDetails.length,
                          product: product,
                        );
                      },
                    );

                  case RequestState.error:
                    return SizedBox(
                      height: 600,
                      child: CustomErrorWidget(
                        errorMessage: state.categoryDetailsErrorMessage,
                        errorCategoryName: extractData['name'] + ' Category',
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
