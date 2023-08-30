import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/errors/failure.dart';

import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/global_constants.dart';
import '../../domain/use cases/login_use_case.dart';
import '../models/auth_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<AuthModel> login(AuthParameters parameters);

  Future<AuthModel> register(AuthParameters parameters);

  Future<AuthModel> getProfile();

  Future<AuthModel> updateProfile(AuthParameters parameters);
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<AuthModel> register(AuthParameters parameters) async {
    final response = await Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'lang': language,
          'Content-Type': 'application/json',
        },
      ),
    ).post(
      ApiConstants.register,
      data: {
        'name': parameters.name,
        'email': parameters.email,
        'password': parameters.password,
        'phone': parameters.phone,
      },
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<AuthModel> login(AuthParameters parameters) async {
    final response = await Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'lang': language,
          'Content-Type': 'application/json',
        },
      ),
    ).post(
      ApiConstants.login,
      data: {
        'email': parameters.email,
        'password': parameters.password,
      },
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<AuthModel> getProfile() async {
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
    ).get(ApiConstants.profile);

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerFailure(response.data);
    }
  }

  @override
  Future<AuthModel> updateProfile(AuthParameters parameters) async {
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
    ).put(
      ApiConstants.updateProfile,
      data: {
        'name': parameters.name,
        'phone': parameters.phone,
        'email': parameters.email,
      },
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerFailure(response.data);
    }
  }
}
