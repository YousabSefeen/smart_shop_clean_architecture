import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/errors/failure.dart';

import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/global_constants.dart';
import '../../domain/use cases/search_product_use_case.dart';
import '../models/search_products_model.dart';

abstract class BaseSearchProductsRemoteDataSource {
  Future<List<SearchProductsModel>> getSearchProducts(
      SearchProductsParameters parameters);
}

class SearchProductsRemoteDataSource
    extends BaseSearchProductsRemoteDataSource {
  @override
  Future<List<SearchProductsModel>> getSearchProducts(
      SearchProductsParameters parameters) async {
    final response = await Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'lang': language,
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      ),
    ).post(ApiConstants.searchProductsPath, data: {
      'text': parameters.nameProduct,
    });

    if (response.statusCode == 200) {
      return List<SearchProductsModel>.from(
        (response.data['data']['data'] as List).map(
          (products) => SearchProductsModel.fromJson(products),
        ),
      );
    } else {
      throw ServerFailure(response.data);
    }
  }
}
