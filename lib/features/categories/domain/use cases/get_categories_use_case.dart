import 'package:dartz/dartz.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base categories repository/base_categories_repository.dart';
import '../entities/categories.dart';

class GetCategoriesUseCase extends BaseUseCase<List<Categories>, NoParameters> {
  final BaseCategoriesRepository baseCategoriesRepository;

  GetCategoriesUseCase({required this.baseCategoriesRepository});

  @override
  Future<Either<Failure, List<Categories>>> call(
      NoParameters parameters) async {
    return await baseCategoriesRepository.getCategories();
  }
}
