import 'package:clot_store/data/data_source/auth_firebase_service.dart';
import 'package:clot_store/domain/entities/app_error.dart';
import 'package:clot_store/domain/entities/params/signup_params.dart';
import 'package:clot_store/domain/repository/auth/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  late final AuthFirebaseService _authFirebaseService;
  @override
  Future<Either<AppError, void>> signUp(SignupParams params) {
    return _authFirebaseService.signUp(params);
  }
}
