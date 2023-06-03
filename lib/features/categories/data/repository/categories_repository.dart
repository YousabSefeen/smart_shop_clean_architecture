import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/base repository/base_categories_ repository.dart';
import '../../domain/entities/categories.dart';
import '../../domain/entities/category_details.dart';
import '../../domain/use cases/get_category_details_use_case.dart';
import '../data source/categories_remote_data_source.dart';

class CategoriesRepository extends BaseCategoriesRepository {
  final BaseCategoriesRemoteDataSource baseCategoriesRemoteDataSource;

  CategoriesRepository({required this.baseCategoriesRemoteDataSource});

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    final result = await baseCategoriesRemoteDataSource.getCategories();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.errorMessageModel.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CategoryDetails>>> getCategoryDetails(
      GetCategoryDetailsParameters parameters) async {
    final result =
        await baseCategoriesRemoteDataSource.getCategoryDetails(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    }
  }
}
