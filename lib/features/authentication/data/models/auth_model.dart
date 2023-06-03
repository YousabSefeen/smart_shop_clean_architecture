import '../../domain/entities/auth.dart';
import 'data_model.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DataModel.fromJson(json['data']) : null,
    );
  }
}
