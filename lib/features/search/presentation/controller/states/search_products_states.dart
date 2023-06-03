import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../domain/entities/search_products.dart';

class SearchProductsStates extends Equatable {
  final List<SearchProducts> searchProducts;

  final RequestState searchProductsState;

  final String searchProductsErrorMessage;

  const SearchProductsStates({
    this.searchProducts = const [],
    this.searchProductsState = RequestState.loaded,
    this.searchProductsErrorMessage = '',
  });

  SearchProductsStates copyWith({
    List<SearchProducts>? searchProducts,
    RequestState? searchProductsState,
    String? searchProductsErrorMessage,
  }) {
    return SearchProductsStates(
      searchProducts: searchProducts ?? this.searchProducts,
      searchProductsState: searchProductsState ?? this.searchProductsState,
      searchProductsErrorMessage:
          searchProductsErrorMessage ?? this.searchProductsErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        searchProducts,
        searchProductsState,
        searchProductsErrorMessage,
      ];
}
