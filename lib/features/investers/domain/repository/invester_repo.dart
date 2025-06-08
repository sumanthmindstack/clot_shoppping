import 'package:dartz/dartz.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/check_kyc_entity.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/get_kyc_user_list_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../entity/account_summary_data_entity.dart';
import '../entity/get_holding_details_entity.dart';
import '../entity/get_invester_list_entitty.dart';
import '../entity/get_kyc_details_entity.dart';
import '../entity/get_lumpsum_data_entity.dart';
import '../entity/get_redeemption_data_entity.dart';
import '../entity/get_sip_data_entity.dart';
import '../entity/get_stp_data_entity.dart';
import '../entity/get_switch_data_entity.dart';
import '../entity/get_swp_data_entity.dart';
import '../entity/get_transaction_details_entity.dart';
import '../entity/investor_profile_data_entity.dart';
import '../entity/portfolio_analysis_entity.dart';
import '../entity/portfolio_analysis_graph_data_entity.dart';
import '../entity/user_goals_entity.dart';

abstract class InvesterRepo {
  Future<Either<AppError, GetInvesterListEntity>> getInvestersList(
      Map<String, dynamic> params);
  Future<Either<AppError, GetKycUserListEntity>> getKycUserList(
      Map<String, dynamic> params);
  Future<Either<AppError, CheckKycEntity>> checkKyc(
      Map<String, dynamic> params);
  Future<Either<AppError, GetKycDetailsEntity>> getKycDetails(
      Map<String, dynamic> params);
  Future<Either<AppError, List<InvestorProfileDataEntity>>> investerProfileData(
      Map<String, dynamic> params);
  Future<Either<AppError, dynamic>> editInvesterDetails(
      Map<String, dynamic> params);
  Future<Either<AppError, dynamic>> changePrimaryBank(
      Map<String, dynamic> params);
  Future<Either<AppError, dynamic>> addNewBank(Map<String, dynamic> params);
  Future<Either<AppError, PortfolioAnalysisEntity>> portfolioAnalysis(
      Map<String, dynamic> params);
  Future<Either<AppError, PortfolioAnalysisGraphDataEntity>>
      portfolioAnalysisGraphData(Map<String, dynamic> params);
  Future<Either<AppError, AccountSummaryDataEntity>> accountSummaryData(
      Map<String, dynamic> params);
  Future<Either<AppError, GetLumpsumDataEntity>> getLumpsumData(
      Map<String, dynamic> params);
  Future<Either<AppError, GetSipDataEntity>> getSipData(
      Map<String, dynamic> params);
  Future<Either<AppError, GetSwitchDataEntity>> getSwitchData(
      Map<String, dynamic> params);
  Future<Either<AppError, GetStpDataEntity>> getStpData(
      Map<String, dynamic> params);
  Future<Either<AppError, GetSwpDataEntity>> getSwpData(
      Map<String, dynamic> params);
  Future<Either<AppError, GetRedeemptionDataEntity>> getRedeemData(
      Map<String, dynamic> params);
  Future<Either<AppError, GetTransactionDetailsEntity>>
      getTransactionDetailsData(Map<String, dynamic> params);
  Future<Either<AppError, GetHoldingDetailsEntity>> getHoldingsDetailsData(
      Map<String, dynamic> params);
  Future<Either<AppError, UserGoalsEntity>> getUserGoalsDetailsData(
      Map<String, dynamic> params);
}
