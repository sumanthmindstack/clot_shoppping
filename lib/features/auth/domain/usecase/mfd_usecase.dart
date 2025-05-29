import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mfd_entity.dart';
import '../entities/params/mfd_params.dart';
import '../repository/auth_repo.dart';

@injectable
class MfdUsecase implements Usecase<MfdEntity, MfdParams> {
  final AuthRepo _authRepo;
  MfdUsecase(this._authRepo);

  @override
  Future<Either<AppError, MfdEntity>> call(MfdParams params) async {
    return await _authRepo.mfd(params.toJson());
  }
}
