import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/dash_monthwise_sip_details_graph_entity.dart';
import '../entities/params/dash_monthwise_sip_details_graph_params.dart';
import '../repository/home_dash_repo.dart';

@injectable
class DashMonthwiseSipDetailsGraphUsecase
    implements
        Usecase<DashMonthwiseSipDetailsGraphEntity,
            DashMonthwiseSipDetailsGraphParams> {
  final HomeDashRepo _homeDashRepo;

  DashMonthwiseSipDetailsGraphUsecase(this._homeDashRepo);

  @override
  Future<Either<AppError, DashMonthwiseSipDetailsGraphEntity>> call(
      DashMonthwiseSipDetailsGraphParams params) async {
    return await _homeDashRepo
        .dashMonthwiseSipDetailsGraphData(params.toJson());
  }
}
