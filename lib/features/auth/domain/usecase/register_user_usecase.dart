import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/params/register_user_params.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/register_user_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repo.dart';

@injectable
class RegisterUserUsecase
    implements Usecase<RegisterUserEntity, RegisterUserParams> {
  final AuthRepo _authRepo;
  RegisterUserUsecase(this._authRepo);

  @override
  Future<Either<AppError, RegisterUserEntity>> call(
      RegisterUserParams params) async {
    return await _authRepo.registerUser(await params.toFormData());
  }
}
