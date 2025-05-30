import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_constants.dart';
import '../models/get_invester_list_response_model.dart';

abstract class InvesterApiService {
  Future<GetInvesterListResponseModel> getInvestersList(
      Map<String, dynamic> params);
}

@LazySingleton(as: InvesterApiService)
class InvesterApiServiceImpl implements InvesterApiService {
  final ApiClient _client;

  InvesterApiServiceImpl(this._client);
  @override
  Future<GetInvesterListResponseModel> getInvestersList(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.getInvestersList,
        queryParameters: params);
    return GetInvesterListResponseModel.fromJson(response);
  }
}
