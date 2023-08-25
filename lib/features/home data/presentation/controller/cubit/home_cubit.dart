import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base  use case/base_use_case.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../domain/use cases/get_banners_use_case.dart';
import '../../../domain/use cases/get_products_use_cases.dart';
import '../states/home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBannersUseCase getBannersUseCase;

  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getBannersUseCase,
    required this.getProductsUseCase,
  }) : super(const HomeState());

  static HomeCubit object(context) => BlocProvider.of(context);

  FutureOr<void> getBanners() async {
    final result = await getBannersUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          bannersState: RequestState.error,
          bannersErrorMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          banners: r,
          bannersState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> getProducts() async {
    final result = await getProductsUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          productsState: RequestState.error,
          productsErrorMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            products: r,
            productsState: RequestState.loaded,
          ),
        );
        allProducts.addAll(r);
        for (var product in r) {
          favorites.addAll({product.id: product.inFavorite});

          carts.addAll({product.id: product.inCart});
        }
      },
    );
  }
}
