import 'package:dartz/dartz.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base home repository/base_home_repository.dart';
import '../entities/banners.dart';

class GetBannersUseCase extends BaseUseCase<List<Banners>, NoParameters> {
  final BaseHomeRepository baseHomeRepository;

  GetBannersUseCase({required this.baseHomeRepository});

  @override
  Future<Either<Failure, List<Banners>>> call(NoParameters parameters) async {
    return await baseHomeRepository.getBanners();
  }
}
