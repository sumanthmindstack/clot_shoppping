import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mfd_patch_entity.dart';
import '../entities/params/contact_details_params.dart';
import '../repository/auth_repo.dart';

@injectable
class ContactDetailsUsecase
    implements Usecase<MfdPatchEntity, ContactDetailsParams> {
  final AuthRepo _authRepo;
  ContactDetailsUsecase(this._authRepo);

  @override
  Future<Either<AppError, MfdPatchEntity>> call(
      ContactDetailsParams params) async {
    return await _authRepo.mfdPatch(params.toJson());
  }
}
