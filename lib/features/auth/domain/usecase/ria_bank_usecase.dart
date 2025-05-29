import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/ria_bank_entity.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/repository/auth_repo.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/params/ria_bank_params.dart';

@injectable
class RiaBankUsecase implements Usecase<RiaBankEntity, RiaBankParams> {
  final AuthRepo _authRepo;

  RiaBankUsecase(this._authRepo);

  @override
  Future<Either<AppError, RiaBankEntity>> call(RiaBankParams params) async {
    return await _authRepo.riaBank(params.toJson());
  }
}
