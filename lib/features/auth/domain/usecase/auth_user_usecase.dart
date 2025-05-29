import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/core/entities/no_params.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/auth_user_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repo.dart';

@injectable
class AuthUserUsecase implements Usecase<AuthUserEntity, NoParams> {
  final AuthRepo _authRepo;

  AuthUserUsecase(this._authRepo);

  @override
  Future<Either<AppError, AuthUserEntity>> call(NoParams noParams) async {
    return await _authRepo.authUser();
  }
}
