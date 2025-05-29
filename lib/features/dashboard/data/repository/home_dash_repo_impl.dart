import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/dashboard/data/data_source/home_dash_api_service.dart';
import 'package:maxwealth_distributor_app/features/dashboard/data/models/dashboard_data_count_response_model.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/repository/home_dash_repo.dart';

import '../../../../core/api/api_call_with_error.dart';
import '../../../../core/entities/app_error.dart';
import '../models/dash_aum_report_graph_response_model.dart';
import '../models/dash_monthwise_invester_details_graph_response_model.dart';
import '../models/dash_monthwise_sip_details_graph_response_model.dart';
import '../models/dash_monthwise_trans_details_graph_response_model.dart';
import '../models/dash_monthwise_user_details_graph_response_model.dart';
import '../models/trans_typewise_returns_response_model.dart';

@LazySingleton(as: HomeDashRepo)
class HomeDashRepoImpl implements HomeDashRepo {
  final HomeDashApiService _homeDashApiService;
  HomeDashRepoImpl(this._homeDashApiService);
  @override
  Future<Either<AppError, DashboardDatacountResponseModel>>
      dashboardDataCount() {
    return ApiCallWithError.call(
      () async {
        final DashboardDatacountResponseModel dashboardDatacountResponseModel =
            await _homeDashApiService.dashboardDataCount();
        return dashboardDatacountResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, DashMonthwiseUserDetailsGraphModel>>
      dashMonthwiseUserDetailsGraphData(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final DashMonthwiseUserDetailsGraphModel
            dashMonthwiseUserDetailsGraphModel =
            await _homeDashApiService.dashMonthwiseUserDetailsGraphData(params);
        return dashMonthwiseUserDetailsGraphModel;
      },
    );
  }

  @override
  Future<Either<AppError, DashMonthwiseInvesterDetailsGraphModel>>
      dashMonthwiseInvesterDetailsGraphData(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final DashMonthwiseInvesterDetailsGraphModel
            dashMonthwiseInvesterDetailsGraphModel = await _homeDashApiService
                .dashMonthwiseInvesterDetailsGraphData(params);
        return dashMonthwiseInvesterDetailsGraphModel;
      },
    );
  }

  @override
  Future<Either<AppError, DashMonthwiseTransDetailsGraphModel>>
      dashMonthwiseTransDetailsGraphData(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final DashMonthwiseTransDetailsGraphModel
            dashMonthwiseTransDetailsGraphModel = await _homeDashApiService
                .dashMonthwiseTransDetailsGraphData(params);
        return dashMonthwiseTransDetailsGraphModel;
      },
    );
  }

  @override
  Future<Either<AppError, TransTypewiseReturnsResponseModel>>
      transTypewiseReturns() {
    return ApiCallWithError.call(
      () async {
        final TransTypewiseReturnsResponseModel
            transTypewiseReturnsResponseModel =
            await _homeDashApiService.transTypewiseReturns();
        return transTypewiseReturnsResponseModel;
      },
    );
  }

  @override
  Future<Either<AppError, DashMonthwiseSipDetailsGraphModel>>
      dashMonthwiseSipDetailsGraphData(Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final DashMonthwiseSipDetailsGraphModel
            dashMonthwiseSipDetailsGraphModel =
            await _homeDashApiService.dashMonthwiseSipDetailsGraphData(params);
        return dashMonthwiseSipDetailsGraphModel;
      },
    );
  }

  @override
  Future<Either<AppError, DashAumReportGraphResponseModel>> dashAumReportGraph(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final DashAumReportGraphResponseModel dashAumReportGraphResponseModel =
            await _homeDashApiService.dashAumReportGraph(params);
        return dashAumReportGraphResponseModel;
      },
    );
  }
}
