import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/dashboard/data/models/dash_monthwise_user_details_graph_response_model.dart';
import 'package:maxwealth_distributor_app/features/dashboard/data/models/dashboard_data_count_response_model.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_constants.dart';
import '../models/dash_monthwise_sip_details_graph_response_model.dart';
import '../models/dash_monthwise_trans_details_graph_response_model.dart';
import '../models/trans_typewise_returns_response_model.dart';

abstract class HomeDashApiService {
  Future<DashboardDatacountResponseModel> dashboardDataCount();
  Future<DashMonthwiseUserDetailsGraphModel> dashMonthwiseUserDetailsGraphData(
      Map<String, dynamic> params);
  Future<DashMonthwiseUserDetailsGraphModel>
      dashMonthwiseInvesterDetailsGraphData(Map<String, dynamic> params);
  Future<DashMonthwiseTransDetailsGraphModel>
      dashMonthwiseTransDetailsGraphData(Map<String, dynamic> params);
  Future<TransTypewiseReturnsResponseModel> transTypewiseReturns();
  Future<DashMonthwiseSipDetailsGraphModel> dashMonthwiseSipDetailsGraphData(
      Map<String, dynamic> params);
}

@LazySingleton(as: HomeDashApiService)
class HomeDashApiServiceImpl implements HomeDashApiService {
  final ApiClient _client;
  HomeDashApiServiceImpl(this._client);

  @override
  Future<DashboardDatacountResponseModel> dashboardDataCount() async {
    final response =
        await _client.get(ApiConstants.dashboardDataCount, requiresToken: true);
    return DashboardDatacountResponseModel.fromJson(response);
  }

  @override
  Future<DashMonthwiseUserDetailsGraphModel> dashMonthwiseUserDetailsGraphData(
      Map<String, dynamic> params) async {
    final response = await _client.get(
        ApiConstants.dashMonthwiseUserDetailsGraph,
        requiresToken: true,
        queryParameters: params);
    return DashMonthwiseUserDetailsGraphModel.fromJson(response);
  }

  @override
  Future<DashMonthwiseUserDetailsGraphModel>
      dashMonthwiseInvesterDetailsGraphData(Map<String, dynamic> params) async {
    final response = await _client.get(
        ApiConstants.dashMonthwiseInvesterDetailsGraph,
        requiresToken: true,
        queryParameters: params);
    return DashMonthwiseUserDetailsGraphModel.fromJson(response);
  }

  @override
  Future<DashMonthwiseTransDetailsGraphModel>
      dashMonthwiseTransDetailsGraphData(Map<String, dynamic> params) async {
    final response = await _client.get(
        ApiConstants.dashMonthwiseTransDetailsGraph,
        requiresToken: true,
        queryParameters: params);
    return DashMonthwiseTransDetailsGraphModel.fromJson(response);
  }

  @override
  Future<TransTypewiseReturnsResponseModel> transTypewiseReturns() async {
    final response = await _client.get(
      ApiConstants.transTypewiseReturns,
      requiresToken: true,
    );
    return TransTypewiseReturnsResponseModel.fromJson(response);
  }

  @override
  Future<DashMonthwiseSipDetailsGraphModel> dashMonthwiseSipDetailsGraphData(
      Map<String, dynamic> params) async {
    final response = await _client.get(
        ApiConstants.dashMonthWiseSipDetailsEndPoint,
        requiresToken: true,
        queryParameters: params);
    return DashMonthwiseSipDetailsGraphModel.fromJson(response);
  }
}
