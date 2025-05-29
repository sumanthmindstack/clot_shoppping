import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/entities/params/dash_monthwise_user_details_graph_params.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/dash_monthwise_invester_details_graph_entity.dart';
import '../repository/home_dash_repo.dart';

@injectable
class DashMonthwiseInvesterDetailsGraphUsecase
    implements
        Usecase<DashMonthwiseInvesterDetailsGraphEntity,
            DashMonthwiseUserDetailsGraphParams> {
  final HomeDashRepo _homeDashRepo;

  DashMonthwiseInvesterDetailsGraphUsecase(this._homeDashRepo);

  @override
  Future<Either<AppError, DashMonthwiseInvesterDetailsGraphEntity>> call(
      DashMonthwiseUserDetailsGraphParams params) async {
    return await _homeDashRepo
        .dashMonthwiseInvesterDetailsGraphData(params.toJson());
  }
}
