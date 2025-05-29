import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/params/mfd_params.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/repository/auth_repo.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/get_euin_details_entity.dart';

@injectable
class GetEUINDetailsUsecase
    implements Usecase<GetEuinDetailsEntity, MfdParams> {
  final AuthRepo _authRepo;

  GetEUINDetailsUsecase(this._authRepo);

  @override
  Future<Either<AppError, GetEuinDetailsEntity>> call(MfdParams params) async {
    return await _authRepo.getEUINDetails(params.toJson());
  }
}
