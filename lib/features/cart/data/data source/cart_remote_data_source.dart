import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/errors/failure.dart';

import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/global_constants.dart';
import '../../domain/use cases/change_cart_use_case.dart';
import '../../domain/use cases/update_cart_use_case.dart';
import '../models/cart_model.dart';
import '../models/change_cart_model.dart';
import '../models/update_cart_model.dart';

abstract class BaseCartRemoteDataSource {
  Future<CartModel> getCart();

  Future<ChangeCartModel> changeCart(ChangeCartParameters parameters);

  Future<UpdateCartModel> updateCar(UpdateCartParameters parameters);
}

class CartRemoteDataSource extends BaseCartRemoteDataSource {
  @override
  Future<CartModel> getCart() async {
    final response = await Dio(
      BaseOptions(
          receiveDataWhenStatusError: true,
          baseUrl: ApiConstants.baseUrl,
          headers: {
            'lang': language,
            'Content-Type': 'application/json',
            'Authorization': token,
          }),
    ).get(ApiConstants.carts);
    if (response.statusCode == 200) {
      return CartModel.fromJson(response.data['data']);
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<ChangeCartModel> changeCart(ChangeCartParameters parameters) async {
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
    ).post(ApiConstants.carts, data: {
      'product_id': parameters.productId,
    });

    if (response.statusCode == 200) {
      return ChangeCartModel.fromJson(response.data);
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<UpdateCartModel> updateCar(UpdateCartParameters parameters) async {
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
    ).put(
      ApiConstants.updateCart(parameters.productId),
      data: {
        'quantity': parameters.quantity,
      },
    );

    if (response.statusCode == 200) {
      return UpdateCartModel.fromJson(response.data['data']['cart']);
    } else {
      throw ServerFailure(response.data);
    }
  }
}
