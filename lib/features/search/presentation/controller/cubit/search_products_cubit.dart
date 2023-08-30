import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../domain/entities/search_products.dart';
import '../../../domain/use cases/search_product_use_case.dart';
import '../states/search_products_states.dart';

class SearchProductsCubit extends Cubit<SearchProductsStates> {
  final SearchProductsUseCase searchProductsUseCase;

  SearchProductsCubit({required this.searchProductsUseCase})
      : super(const SearchProductsStates());

  static SearchProductsCubit object(context) => BlocProvider.of(context);

  List<SearchProducts> searchProducts = [];

  FutureOr<void> getSearchProducts({required String nameProduct}) async {
    emit(state.copyWith(
      searchProductsState: RequestState.loading,
    ));
    final result = await searchProductsUseCase(
        SearchProductsParameters(nameProduct: nameProduct));
    result.fold(
      (l) => emit(
        state.copyWith(
          searchProductsState: RequestState.error,
          searchProductsErrorMessage: l.errorMessage,
        ),
      ),
      (r) {
        ///The list of search products is placed in another list
        ///to be manipulated and deleted at the logout button (AuthCubit)
        searchProducts = r;
        emit(
          state.copyWith(
            searchProducts: r,
            searchProductsState: RequestState.loaded,
          ),
        );
      },
    );
  }
}
