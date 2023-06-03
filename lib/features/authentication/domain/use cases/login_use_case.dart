import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base auth repository/base_auth_repository.dart';
import '../entities/auth.dart';

class LoginUseCase extends BaseUseCase<Auth, AuthParameters> {
  BaseAuthRepository baseAuthRepository;

  LoginUseCase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, Auth>> call(AuthParameters parameters) async {
    return await baseAuthRepository.login(parameters);
  }
}

class AuthParameters extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;

  const AuthParameters({
    this.name,
    this.phone,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [name, phone, email, password];
}
