import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/params/address_details_params.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mfd_patch_entity.dart';
import '../repository/auth_repo.dart';

@injectable
class MfdPatchAddressDetailsUsecase
    implements Usecase<MfdPatchEntity, AddressDetailsParams> {
  final AuthRepo _authRepo;
  MfdPatchAddressDetailsUsecase(this._authRepo);

  @override
  Future<Either<AppError, MfdPatchEntity>> call(
      AddressDetailsParams params) async {
    return await _authRepo.mfdPatch(params.toJson());
  }
}
