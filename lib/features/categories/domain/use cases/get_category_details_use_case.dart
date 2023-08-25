import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base categories repository/base_categories_repository.dart';
import '../entities/category_details.dart';

class GetCategoryDetailsUseCase
    extends BaseUseCase<List<CategoryDetails>, GetCategoryDetailsParameters> {
  final BaseCategoriesRepository baseCategoriesRepository;

  GetCategoryDetailsUseCase({required this.baseCategoriesRepository});

  @override
  Future<Either<Failure, List<CategoryDetails>>> call(
      GetCategoryDetailsParameters parameters) async {
    return await baseCategoriesRepository.getCategoryDetails(parameters);
  }
}

class GetCategoryDetailsParameters extends Equatable {
  final int categoryId;

  const GetCategoryDetailsParameters({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
