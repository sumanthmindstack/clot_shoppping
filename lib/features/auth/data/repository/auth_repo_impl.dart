import 'package:dartz/dartz.dart';
import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/core/api/api_call_with_error.dart';
import 'package:maxwealth_distributor_app/core/entities/app_error.dart';
import 'package:maxwealth_distributor_app/features/auth/data/data_source/auth_api_services.dart';
import 'package:maxwealth_distributor_app/features/auth/data/models/auth_user_response_model.dart';
import 'package:maxwealth_distributor_app/features/auth/data/models/euin_response_model.dart';
import 'package:maxwealth_distributor_app/features/auth/data/models/mfd_response_model.dart';
import 'package:maxwealth_distributor_app/features/auth/data/models/user_response_model.dart';

import '../../../../core/data_source/token_local_data_source.dart';
import '../../../../core/data_source/user_local_data_source.dart';
import '../../../../core/entities/user_local.dart';
import '../../domain/repository/auth_repo.dart';
import '../models/find_one_response_model.dart';
import '../models/get_euin_details_response_model.dart';
import '../models/mdf_patch_response_model.dart';
import '../models/register_user_response_model.dart';
import '../models/ria_bank_response_model.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthApiServices _authApiServices;
  final TokenLocalDataSource _tokenLocalDataSource;

  final UserLocalDataSource _userLocalDataSource;

  AuthRepoImpl(this._authApiServices, this._userLocalDataSource,
      this._tokenLocalDataSource);
  @override
  Future<Either<AppError, dynamic>> generateOTP(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final response = await _authApiServices.generateOTP(params);
        return response;
      },
    );
  }

  @override
  Future<Either<AppError, dynamic>> verifyOTP(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final UserResponseModel userResponseModel =
            await _authApiServices.verifyOTP(params);
        await _userLocalDataSource.storeUserData(UserLocal(
            id: userResponseModel.id.toString(),
            name: userResponseModel.fullName.toString(),
            email: userResponseModel.email.toString(),
            isKycVerified: false));
        print("access token ${userResponseModel.accessToken}");
        await _tokenLocalDataSource
            .setAccessToken(userResponseModel.accessToken.toString());
        return userResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, RegisterUserResponseModel>> registerUser(
      FormData params) async {
    return ApiCallWithError.call(
      () async {
        final RegisterUserResponseModel registerUserResponseModel =
            await _authApiServices.registerUser(params);
        return registerUserResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, AuthUserResponseModel>> authUser() async {
    return ApiCallWithError.call(
      () async {
        final AuthUserResponseModel authUserResponseModel =
            await _authApiServices.authUser();
        return authUserResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, MfdResponseModel>> mfd(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final MfdResponseModel mfdResponseModel =
            await _authApiServices.mfd(params);
        return mfdResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, FindOneResponseModel>> findOne(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final FindOneResponseModel findOneResponseModel =
            await _authApiServices.findOne(params);
        return findOneResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, MfdPatchResponseModel>> mfdPatch(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final MfdPatchResponseModel mfdPatchResponseModel =
            await _authApiServices.mfdPatch(params);
        return mfdPatchResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, GetEuinDetailsResponseModel>> getEUINDetails(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final GetEuinDetailsResponseModel getEuinDetailsResponseModel =
            await _authApiServices.getEUINDetails(params);
        return getEuinDetailsResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, EuinResponseModel>> euin(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final EuinResponseModel euinResponseModel =
            await _authApiServices.euin(params);
        return euinResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, MfdResponseModel>> ria(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final MfdResponseModel mfdResponseModel =
            await _authApiServices.ria(params);
        return mfdResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, MfdPatchResponseModel>> riaPatch(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final MfdPatchResponseModel mfdPatchResponseModel =
            await _authApiServices.riaPatch(params);
        return mfdPatchResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, RiaBankResponseModel>> riaBank(
      Map<String, dynamic> params) async {
    return ApiCallWithError.call(
      () async {
        final RiaBankResponseModel mfdPatchResponseModel =
            await _authApiServices.riaBank(params);
        return mfdPatchResponseModel;
      },
    );
  }
}
