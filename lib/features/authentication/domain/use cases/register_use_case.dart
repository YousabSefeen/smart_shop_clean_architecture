import 'package:dartz/dartz.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base auth repository/base_auth_repository.dart';
import '../entities/auth.dart';
import 'login_use_case.dart';

class RegisterUseCase extends BaseUseCase<Auth, AuthParameters> {
  final BaseAuthRepository baseAuthRepository;

  RegisterUseCase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, Auth>> call(AuthParameters parameters) async {
    return await baseAuthRepository.register(parameters);
  }
}
