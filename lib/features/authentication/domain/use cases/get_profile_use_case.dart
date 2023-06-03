import 'package:dartz/dartz.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base auth repository/base_auth_repository.dart';
import '../entities/auth.dart';

class GetProfileUseCase extends BaseUseCase<Auth, NoParameters> {
  final BaseAuthRepository baseAuthRepository;

  GetProfileUseCase({required this.baseAuthRepository});

  @override
  Future<Either<Failure, Auth>> call(NoParameters parameters) async {
    return await baseAuthRepository.getProfile();
  }
}
