import 'package:clot_store/domain/entities/app_error.dart';
import 'package:clot_store/domain/entities/params/signup_params.dart';
import 'package:clot_store/domain/entities/usecase.dart';
import 'package:clot_store/domain/repository/auth/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase extends UseCase<void, SignupParams> {
  late final AuthRepo _authRepo;
  @override
  Future<Either<AppError, void>> call(params) async {
    return await _authRepo.signUp(params);
  }
}
