import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/errors/failure.dart';

import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/global_constants.dart';
import '../../domain/use cases/get_category_details_use_case.dart';
import '../models/categories_model.dart';
import '../models/category_details_model.dart';

abstract class BaseCategoriesRemoteDataSource {
  Future<List<CategoriesModel>> getCategories();

  Future<List<CategoryDetailsModel>> getCategoryDetails(
      GetCategoryDetailsParameters parameters);
}

class CategoriesRemoteDataSource extends BaseCategoriesRemoteDataSource {
  @override
  Future<List<CategoriesModel>> getCategories() async {
    final response = await Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'lang': language,
        },
      ),
    ).get(ApiConstants.categoriesPath);

    if (response.statusCode == 200) {
      return List<CategoriesModel>.from(
        (response.data['data']['data'] as List)
            .map((category) => CategoriesModel.fromJson(category)),
      );
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<List<CategoryDetailsModel>> getCategoryDetails(
      GetCategoryDetailsParameters parameters) async {
    final response = await Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'lang': language,
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      ),
    ).get(
      ApiConstants.getCategoryDetails(parameters.categoryId),
    );

    if (response.statusCode == 200) {
      return List<CategoryDetailsModel>.from(
          (response.data['data']['data'] as List)
              .map((products) => CategoryDetailsModel.fromJson(products)));
    } else {
      throw ServerFailure(response.data);
    }
  }
}
