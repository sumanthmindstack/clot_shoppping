import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/mfd_patch_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/params/ria_patch_params.dart';
import '../repository/auth_repo.dart';

@injectable
class RiaPatchUsecase implements Usecase<MfdPatchEntity, RiaPatchParams> {
  final AuthRepo _authRepo;

  RiaPatchUsecase(this._authRepo);

  @override
  Future<Either<AppError, MfdPatchEntity>> call(RiaPatchParams params) async {
    return await _authRepo.riaPatch(params.toJson());
  }
}
