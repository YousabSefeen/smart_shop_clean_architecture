import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../categories/domain/entities/categories.dart';
import '../entities/category_details.dart';
import '../use cases/get_category_details_use_case.dart';

abstract class BaseCategoriesRepository {
  Future<Either<Failure, List<Categories>>> getCategories();

  Future<Either<Failure, List<CategoryDetails>>> getCategoryDetails(
    GetCategoryDetailsParameters parameters,
  );
}
