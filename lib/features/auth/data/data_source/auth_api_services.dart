import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/core/api/api_constants.dart';
import 'package:maxwealth_distributor_app/features/auth/data/models/auth_user_response_model.dart';
import 'package:maxwealth_distributor_app/features/auth/data/models/mfd_response_model.dart';
import 'package:maxwealth_distributor_app/features/auth/data/models/user_response_model.dart';

import '../../../../core/api/api_client.dart';
import '../models/euin_response_model.dart';
import '../models/find_one_response_model.dart';
import '../models/get_euin_details_response_model.dart';
import '../models/mdf_patch_response_model.dart';
import '../models/register_user_response_model.dart';
import '../models/ria_bank_response_model.dart';

abstract class AuthApiServices {
  Future<dynamic> generateOTP(Map<String, dynamic> params);
  Future<dynamic> verifyOTP(Map<String, dynamic> params);
  Future<RegisterUserResponseModel> registerUser(FormData params);
  Future<AuthUserResponseModel> authUser();
  //MFD Flow
  Future<MfdResponseModel> mfd(Map<String, dynamic> params);
  Future<FindOneResponseModel> findOne(Map<String, dynamic> params);
  Future<MfdPatchResponseModel> mfdPatch(Map<String, dynamic> params);
  Future<GetEuinDetailsResponseModel> getEUINDetails(
      Map<String, dynamic> params);
  Future<EuinResponseModel> euin(Map<String, dynamic> params);
  //RIA Flow
  Future<MfdResponseModel> ria(Map<String, dynamic> params);
  Future<MfdPatchResponseModel> riaPatch(Map<String, dynamic> params);
  Future<RiaBankResponseModel> riaBank(Map<String, dynamic> params);
}

@LazySingleton(as: AuthApiServices)
class AuthApiServiceIMpl implements AuthApiServices {
  final ApiClient _client;
  AuthApiServiceIMpl(this._client);
  @override
  Future generateOTP(Map<String, dynamic> params) {
    final response =
        _client.post(ApiConstants.generateOTPEndPoint, params: params);
    return response;
  }

  @override
  Future<UserResponseModel> verifyOTP(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.verifyOTPEndPoint,
      params: params,
    );
    return UserResponseModel.fromJson(response);
  }

  @override
  Future<RegisterUserResponseModel> registerUser(FormData params) async {
    final response = await _client.post(ApiConstants.registerUserEndPoint,
        formData: params, isFormData: true);
    return RegisterUserResponseModel.fromJson(response["user"]);
  }

  @override
  Future<AuthUserResponseModel> authUser() async {
    final response =
        await _client.get(ApiConstants.authUserEndPoint, requiresToken: true);
    return AuthUserResponseModel.fromJson(response["data"]);
  }

  @override
  Future<MfdResponseModel> mfd(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.mfdEndPoint,
      params: params,
    );
    return MfdResponseModel.fromJson(response["user"]);
  }

  @override
  Future<FindOneResponseModel> findOne(Map<String, dynamic> params) async {
    final response = await _client.get(
      ApiConstants.findOneEndPoint,
      queryParameters: params,
    );
    return FindOneResponseModel.fromJson(response["user"]);
  }

  @override
  Future<MfdPatchResponseModel> mfdPatch(Map<String, dynamic> params) async {
    final id = params["id"];
    final filteredParams = Map<String, dynamic>.from(params)..remove("id");
    final response = await _client.patch(
      ApiConstants.mfdEndPoint,
      queryParams: {"id": id},
      params: filteredParams,
    );
    return MfdPatchResponseModel.fromJson(response);
  }

  @override
  Future<GetEuinDetailsResponseModel> getEUINDetails(
      Map<String, dynamic> params) async {
    final response = await _client.get(
      ApiConstants.getEUINDataEndPoint,
      queryParameters: params,
    );
    return GetEuinDetailsResponseModel.fromJson(response);
  }

  @override
  Future<EuinResponseModel> euin(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.euinEndPoint,
      params: params,
    );
    return EuinResponseModel.fromJson(response);
  }

  @override
  Future<MfdResponseModel> ria(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.registerRiaUserEndPoint,
      params: params,
    );
    return MfdResponseModel.fromJson(response["user"]);
  }

  @override
  Future<MfdPatchResponseModel> riaPatch(Map<String, dynamic> params) async {
    final id = params["id"];
    final filteredParams = Map<String, dynamic>.from(params)..remove("id");
    final response = await _client.patch(
      ApiConstants.registerRiaUserEndPoint,
      queryParams: {"id": id},
      params: filteredParams,
    );
    return MfdPatchResponseModel.fromJson(response);
  }

  @override
  Future<RiaBankResponseModel> riaBank(Map<String, dynamic> params) async {
    final response = await _client.post(
      ApiConstants.riaBankUserEndPoint,
      params: params,
    );
    return RiaBankResponseModel.fromJson(response);
  }
}
