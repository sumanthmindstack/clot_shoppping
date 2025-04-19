import 'package:clot_store/domain/entities/app_error.dart';
import 'package:clot_store/domain/entities/params/signup_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<AppError, dynamic>> signUp(SignupParams params);
}
