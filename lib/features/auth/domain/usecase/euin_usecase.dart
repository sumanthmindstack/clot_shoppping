import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/repository/auth_repo.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/euin_entity.dart';
import '../entities/params/euin_params.dart';

@injectable
class EuinUsecase implements Usecase<EuinEntity, EuinParams> {
  final AuthRepo _authRepo;

  EuinUsecase(this._authRepo);

  @override
  Future<Either<AppError, EuinEntity>> call(EuinParams params) async {
    return await _authRepo.euin(params.toJson());
  }
}
