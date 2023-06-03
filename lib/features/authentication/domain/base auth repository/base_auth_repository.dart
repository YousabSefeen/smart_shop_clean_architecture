import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/auth.dart';
import '../use cases/login_use_case.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, Auth>> login(AuthParameters parameters);

  Future<Either<Failure, Auth>> register(AuthParameters parameters);

  Future<Either<Failure, Auth>> getProfile();

  Future<Either<Failure, Auth>> updateProfile(
    AuthParameters parameters,
  );
}
