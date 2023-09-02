import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/errors/failure.dart';

import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/global_constants.dart';
import '../../domain/use cases/change_favorite_use_case.dart';
import '../models/change_favorite_model.dart';
import '../models/favorites_model.dart';

abstract class BaseFavoritesRemoteDataSource {
  Future<List<FavoritesModel>> getFavorites();

  Future<ChangeFavoriteModel> changeFavorite(
      ChangeFavoriteParameters parameters);
}

class FavoritesRemoteDataSource extends BaseFavoritesRemoteDataSource {
  @override
  Future<List<FavoritesModel>> getFavorites() async {
    final response = await Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'lang': language,
          'Content-Type': 'application/json',
          'Authorization': token,
        })).get(ApiConstants.favoritesPath);

    if (response.statusCode == 200) {
      return List<FavoritesModel>.from((response.data['data']['data'] as List)
          .map((e) => FavoritesModel.fromJson(e)));
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<ChangeFavoriteModel> changeFavorite(
      ChangeFavoriteParameters parameters) async {
    final response = await Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: ApiConstants.baseUrl,
        headers: {
          'lang': language,
          'Content-Type': 'application/json',
          'Authorization': token,
        })).post(ApiConstants.favoritesPath, data: {
      'product_id': parameters.id,
    });

    if (response.statusCode == 200) {
      return ChangeFavoriteModel.fromJson(response.data);
    } else {
      throw ServerFailure(response.data);
    }
  }
}
