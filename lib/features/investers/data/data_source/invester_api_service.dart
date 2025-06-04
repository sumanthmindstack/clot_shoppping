import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_constants.dart';
import '../models/account_summary_data_response_model.dart';
import '../models/check_kyc_response_model.dart';
import '../models/get_invester_list_response_model.dart';
import '../models/get_kyc_details_response_model.dart';
import '../models/get_kyc_user_list_response_model.dart';
import '../models/get_lumpsum_data_response_model.dart';
import '../models/investor_profile_data_response_model.dart';
import '../models/portfolio_analysis_graph_data_response_model.dart';
import '../models/portfolio_analysis_response_model.dart';

abstract class InvesterApiService {
  Future<GetInvesterListResponseModel> getInvestersList(
      Map<String, dynamic> params);
  Future<GetKycUserListResponseModel> getKycUserList(
      Map<String, dynamic> params);
  Future<CheckKycResponseModel> checkKyc(Map<String, dynamic> params);
  Future<GetKycDetailsResponseModel> getKycDetails(Map<String, dynamic> params);
  Future<List<InvestorProfileDataResponseModel>> investerProfileData(
      Map<String, dynamic> params);
  Future<dynamic> editInvesterDetails(Map<String, dynamic> params);
  Future<dynamic> changePrimaryBank(Map<String, dynamic> params);
  Future<dynamic> addNewBank(Map<String, dynamic> params);
  Future<PortfolioAnalysisResponseModel> portfolioAnalysis(
      Map<String, dynamic> params);
  Future<PortfolioAnalysisGraphDataResponseModel> portfolioAnalysisGraphData(
      Map<String, dynamic> params);
  Future<AccountSummaryDataResponseModel> accountSummaryData(
      Map<String, dynamic> params);
  Future<GetLumpsumDataResponseModel> getLumpsumData(
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

  @override
  Future<GetKycUserListResponseModel> getKycUserList(
      Map<String, dynamic> params) async {
    final response =
        await _client.get(ApiConstants.getKycUserList, queryParameters: params);
    return GetKycUserListResponseModel.fromJson(response);
  }

  @override
  Future<CheckKycResponseModel> checkKyc(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.checkKyCEndpoint,
        params: params, requiresToken: true);
    return CheckKycResponseModel.fromJson(response["data"]);
  }

  @override
  Future<GetKycDetailsResponseModel> getKycDetails(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.getKycDetailsEndpoint,
        queryParameters: params, requiresToken: true);
    return GetKycDetailsResponseModel.fromJson(response);
  }

  @override
  Future<List<InvestorProfileDataResponseModel>> investerProfileData(
      Map<String, dynamic> params) async {
    final response = await _client.get(
      ApiConstants.getInvesterProfileDataEndpoint,
      queryParameters: params,
      requiresToken: true,
    );

    final List<dynamic> data = response;

    return data
        .map((json) => InvestorProfileDataResponseModel.fromJson(json))
        .toList();
  }

  @override
  Future editInvesterDetails(Map<String, dynamic> params) async {
    final response =
        await _client.patch(ApiConstants.editInvesterEndpoint, params: params);
    return response;
  }

  @override
  Future changePrimaryBank(Map<String, dynamic> params) async {
    final response = await _client.patch(ApiConstants.changePrimaryBankEndpoint,
        params: params);
    return response;
  }

  @override
  Future addNewBank(Map<String, dynamic> params) async {
    final response = await _client.post(ApiConstants.addNewBankEndpoint,
        params: params, requiresToken: true);
    return response;
  }

  @override
  Future<PortfolioAnalysisResponseModel> portfolioAnalysis(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.portFolioSummaryEndpoint,
        queryParameters: params, requiresToken: true);
    return PortfolioAnalysisResponseModel.fromJson(response);
  }

  @override
  Future<PortfolioAnalysisGraphDataResponseModel> portfolioAnalysisGraphData(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.portFolioGraphDataEndpoint,
        queryParameters: params, requiresToken: true);
    return PortfolioAnalysisGraphDataResponseModel.fromJson(response);
  }

  @override
  Future<AccountSummaryDataResponseModel> accountSummaryData(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.accountSummaryDataEndpoint,
        queryParameters: params, requiresToken: true);
    return AccountSummaryDataResponseModel.fromJson(response);
  }

  @override
  Future<GetLumpsumDataResponseModel> getLumpsumData(
      Map<String, dynamic> params) async {
    final response = await _client.get(ApiConstants.getLumpsumDataEndpoint,
        queryParameters: params, requiresToken: true);
    return GetLumpsumDataResponseModel.fromJson(response);
  }
}
