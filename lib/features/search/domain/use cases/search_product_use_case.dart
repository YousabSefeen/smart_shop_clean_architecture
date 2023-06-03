import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base search repository/base_search_products_repository.dart';
import '../entities/search_products.dart';

class SearchProductsUseCase
    extends BaseUseCase<List<SearchProducts>, SearchProductsParameters> {
  final BaseSearchProductsRepository baseSearchProductsRepository;

  SearchProductsUseCase({
    required this.baseSearchProductsRepository,
  });

  @override
  Future<Either<Failure, List<SearchProducts>>> call(
      SearchProductsParameters parameters) async {
    return await baseSearchProductsRepository.getSearchProducts(parameters);
  }
}

class SearchProductsParameters extends Equatable {
  final String nameProduct;

  const SearchProductsParameters({required this.nameProduct});

  @override
  List<Object> get props => [nameProduct];
}
