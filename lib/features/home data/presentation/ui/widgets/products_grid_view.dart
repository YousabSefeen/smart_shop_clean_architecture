import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/custom_error_widget.dart';
import 'package:shop_app_clean_architecture/core/common%20presentation/widgets/product_item.dart';
import 'package:shop_app_clean_architecture/core/utils/app%20settings/components/app_localizations.dart';

import '../../../../../core/common presentation/widgets/loading_grid_view.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../domain/entities/products.dart';
import '../../controller/cubit/home_cubit.dart';
import '../../controller/states/home_states.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.productsState) {
          case RequestState.loading:
            return const LoadingGridView();
          case RequestState.loaded:
            return GridView.builder(
              shrinkWrap: true,

              /// It is very important that someone else can get me an error
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),

              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),
              itemCount: state.products.length,

              itemBuilder: (ctx, index) {
                Products product = state.products[index];
                return ProductItem(
                  index: index,
                  itemCount: state.products.length,
                  product: product,
                );
              },
            );

          case RequestState.error:
            return CustomErrorWidget(
              errorMessage: state.productsErrorMessage,
              errorCategoryName: 'bestSelling'.translate(context),
            );
        }
      },
    );
  }
}
