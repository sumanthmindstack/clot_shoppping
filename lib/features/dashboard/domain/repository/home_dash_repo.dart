import 'package:dartz/dartz.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/entities/dash_monthwise_user_details_graph_entity.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/entities/dashboard_data_count_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../entities/dash_monthwise_sip_details_graph_entity.dart';
import '../entities/dash_monthwise_trans_details_graph_entity.dart';
import '../entities/trans_typewise_returns_entity.dart';

abstract class HomeDashRepo {
  Future<Either<AppError, DashboardDatacountEntity>> dashboardDataCount();
  Future<Either<AppError, DashMonthwiseUserDetailsGraphEntity>>
      dashMonthwiseUserDetailsGraphData(Map<String, dynamic> params);
  Future<Either<AppError, DashMonthwiseUserDetailsGraphEntity>>
      dashMonthwiseInvesterDetailsGraphData(Map<String, dynamic> params);
  Future<Either<AppError, DashMonthwiseTransDetailsGraphEntity>>
      dashMonthwiseTransDetailsGraphData(Map<String, dynamic> params);
  Future<Either<AppError, TransTypewiseReturnsResponseEntity>>
      transTypewiseReturns();
  Future<Either<AppError, DashMonthwiseSipDetailsGraphEntity>>
      dashMonthwiseSipDetailsGraphData(Map<String, dynamic> params);
}
