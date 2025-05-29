import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/euin_entity.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/register_user_entity.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/ria_bank_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../entities/find_one_entity.dart';
import '../entities/get_euin_details_entity.dart';
import '../entities/mfd_entity.dart';
import '../entities/mfd_patch_entity.dart';

abstract class AuthRepo {
  Future<Either<AppError, dynamic>> generateOTP(Map<String, dynamic> params);
  Future<Either<AppError, dynamic>> verifyOTP(Map<String, dynamic> params);
  Future<Either<AppError, RegisterUserEntity>> registerUser(FormData params);
  Future<Either<AppError, AuthUserEntity>> authUser();

  Future<Either<AppError, MfdEntity>> mfd(Map<String, dynamic> params);
  Future<Either<AppError, FindOneEntity>> findOne(Map<String, dynamic> params);
  Future<Either<AppError, MfdPatchEntity>> mfdPatch(
      Map<String, dynamic> params);
  Future<Either<AppError, GetEuinDetailsEntity>> getEUINDetails(
      Map<String, dynamic> params);
  Future<Either<AppError, EuinEntity>> euin(Map<String, dynamic> params);

  Future<Either<AppError, MfdEntity>> ria(Map<String, dynamic> params);
  Future<Either<AppError, MfdPatchEntity>> riaPatch(
      Map<String, dynamic> params);
  Future<Either<AppError, RiaBankEntity>> riaBank(Map<String, dynamic> params);
}
