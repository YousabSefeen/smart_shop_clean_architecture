import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/base categories repository/base_categories_repository.dart';
import '../../domain/entities/categories.dart';
import '../../domain/entities/category_details.dart';
import '../../domain/use cases/get_category_details_use_case.dart';
import '../data source/categories_remote_data_source.dart';

class CategoriesRepository extends BaseCategoriesRepository {
  final BaseCategoriesRemoteDataSource baseCategoriesRemoteDataSource;

  CategoriesRepository({required this.baseCategoriesRemoteDataSource});

  @override
  Future<Either<Failure, List<Categories>>> getCategories() async {
    try {
      final result = await baseCategoriesRemoteDataSource.getCategories();
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<CategoryDetails>>> getCategoryDetails(
      GetCategoryDetailsParameters parameters) async {
    try {
      final result =
          await baseCategoriesRemoteDataSource.getCategoryDetails(parameters);
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
