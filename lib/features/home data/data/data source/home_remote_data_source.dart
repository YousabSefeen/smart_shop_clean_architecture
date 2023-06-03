import 'package:dio/dio.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/error_message_model.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/global_constants.dart';
import '../models/banners_model.dart';
import '../models/products_model.dart';

abstract class BaseHomeRemoteDataSource {
  Future<List<BannersModel>> getBanners();

  Future<List<ProductsModel>> getProducts();
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  @override
  Future<List<BannersModel>> getBanners() async {
    final response = await Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: ApiConstants.baseUrl,
      ),
    ).get(ApiConstants.bannersPath);

    if (response.statusCode == 200) {
      return List<BannersModel>.from(
          (response.data['data']['banners'] as List).map(
        (banner) => BannersModel.fromJson(banner),
      ));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<ProductsModel>> getProducts() async {
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
    ).get(ApiConstants.productsPath);

    if (response.statusCode == 200) {
      return List<ProductsModel>.from(
        (response.data['data']['products'] as List).map(
          (product) => ProductsModel.fromJson(product),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
