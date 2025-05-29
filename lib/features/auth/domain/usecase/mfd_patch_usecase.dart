import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/repository/auth_repo.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mfd_patch_entity.dart';
import '../entities/params/mfd_patch_params.dart';

@injectable
class MfdPatchUsecase implements Usecase<MfdPatchEntity, MfdPatchParams> {
  final AuthRepo _authRepo;

  MfdPatchUsecase(this._authRepo);

  @override
  Future<Either<AppError, MfdPatchEntity>> call(MfdPatchParams params) async {
    return await _authRepo.mfdPatch(params.toJson());
  }
}
