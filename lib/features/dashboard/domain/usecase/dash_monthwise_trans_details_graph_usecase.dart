import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/dash_monthwise_trans_details_graph_entity.dart';
import '../entities/params/dash_monthwise_trans_details_graph_params.dart';
import '../repository/home_dash_repo.dart';

@injectable
class DashMonthwiseTransDetailsGraphUsecase
    implements
        Usecase<DashMonthwiseTransDetailsGraphEntity,
            DashMonthwiseTransDetailsGraphParams> {
  final HomeDashRepo _homeDashRepo;

  DashMonthwiseTransDetailsGraphUsecase(this._homeDashRepo);

  @override
  Future<Either<AppError, DashMonthwiseTransDetailsGraphEntity>> call(
      DashMonthwiseTransDetailsGraphParams params) async {
    return await _homeDashRepo
        .dashMonthwiseTransDetailsGraphData(params.toJson());
  }
}
