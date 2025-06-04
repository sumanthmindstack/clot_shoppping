import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/data/models/portfolio_analysis_graph_data_response_model.dart';
import 'package:maxwealth_distributor_app/features/investers/data/models/portfolio_analysis_response_model.dart';

import '../../../../core/api/api_call_with_error.dart';
import '../../../../core/entities/app_error.dart';
import '../../domain/entity/portfolio_analysis_entity.dart';
import '../../domain/entity/portfolio_analysis_graph_data_entity.dart';
import '../../domain/repository/invester_repo.dart';
import '../data_source/invester_api_service.dart';
import '../models/account_summary_data_response_model.dart';
import '../models/check_kyc_response_model.dart';
import '../models/get_invester_list_response_model.dart';
import '../models/get_kyc_details_response_model.dart';
import '../models/get_kyc_user_list_response_model.dart';
import '../models/get_lumpsum_data_response_model.dart';
import '../models/investor_profile_data_response_model.dart';

@LazySingleton(as: InvesterRepo)
class InvesterRepoImpl implements InvesterRepo {
  final InvesterApiService _investerApiService;
  InvesterRepoImpl(this._investerApiService);
  @override
  Future<Either<AppError, GetInvesterListResponseModel>> getInvestersList(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final GetInvesterListResponseModel dashboardDatacountResponseModel =
            await _investerApiService.getInvestersList(params);
        return dashboardDatacountResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, GetKycUserListResponseModel>> getKycUserList(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final GetKycUserListResponseModel dashboardDatacountResponseModel =
            await _investerApiService.getKycUserList(params);
        return dashboardDatacountResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, CheckKycResponseModel>> checkKyc(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final CheckKycResponseModel checkKycResponseModel =
            await _investerApiService.checkKyc(params);
        return checkKycResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, GetKycDetailsResponseModel>> getKycDetails(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final GetKycDetailsResponseModel getKycDetailsResponseModel =
            await _investerApiService.getKycDetails(params);
        return getKycDetailsResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, List<InvestorProfileDataResponseModel>>>
      investerProfileData(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final List<InvestorProfileDataResponseModel>
            investerProfileDataResponseModel =
            await _investerApiService.investerProfileData(params);
        return investerProfileDataResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, PortfolioAnalysisEntity>> editInvesterDetails(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        return await _investerApiService.portfolioAnalysis(params);
      },
    );
  }

  @override
  Future<Either<AppError, dynamic>> changePrimaryBank(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        await _investerApiService.changePrimaryBank(params);
      },
    );
  }

  @override
  Future<Either<AppError, dynamic>> addNewBank(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        await _investerApiService.addNewBank(params);
      },
    );
  }

  @override
  Future<Either<AppError, PortfolioAnalysisResponseModel>> portfolioAnalysis(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        return await _investerApiService.portfolioAnalysis(params);
      },
    );
  }

  @override
  Future<Either<AppError, PortfolioAnalysisGraphDataResponseModel>>
      portfolioAnalysisGraphData(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        return await _investerApiService.portfolioAnalysisGraphData(params);
      },
    );
  }

  @override
  Future<Either<AppError, AccountSummaryDataResponseModel>> accountSummaryData(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        return await _investerApiService.accountSummaryData(params);
      },
    );
  }

  @override
  Future<Either<AppError, GetLumpsumDataResponseModel>> getLumpsumData(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        return await _investerApiService.getLumpsumData(params);
      },
    );
  }
}
