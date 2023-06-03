import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../domain/entities/banners.dart';
import '../../../domain/entities/products.dart';

class HomeState extends Equatable {
  final List<Banners> banners;
  final RequestState bannersState;
  final String bannersErrorMessage;

  final List<Products> products;
  final RequestState productsState;
  final String productsErrorMessage;

  const HomeState({
    this.banners = const [],
    this.bannersState = RequestState.loading,
    this.bannersErrorMessage = '',
    this.products = const [],
    this.productsState = RequestState.loading,
    this.productsErrorMessage = '',
  });

  HomeState copyWith({
    List<Banners>? banners,
    RequestState? bannersState,
    String? bannersErrorMessage,
    List<Products>? products,
    RequestState? productsState,
    String? productsErrorMessage,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      bannersState: bannersState ?? this.bannersState,
      bannersErrorMessage: bannersErrorMessage ?? this.bannersErrorMessage,
      products: products ?? this.products,
      productsState: productsState ?? this.productsState,
      productsErrorMessage: productsErrorMessage ?? this.productsErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        banners,
        bannersState,
        bannersErrorMessage,
        products,
        productsState,
        productsErrorMessage,
      ];
}
