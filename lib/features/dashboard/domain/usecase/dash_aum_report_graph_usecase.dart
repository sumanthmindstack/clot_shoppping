import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/dash_aum_report_graph_entity.dart';
import '../entities/params/dash_monthwise_trans_details_graph_params.dart';
import '../repository/home_dash_repo.dart';

@injectable
class DashAumReportGraphUsecase
    implements
        Usecase<DashAumReportGraphEntity,
            DashMonthwiseTransDetailsGraphParams> {
  final HomeDashRepo _homeDashRepo;

  DashAumReportGraphUsecase(this._homeDashRepo);

  @override
  Future<Either<AppError, DashAumReportGraphEntity>> call(
      DashMonthwiseTransDetailsGraphParams params) async {
    return await _homeDashRepo.dashAumReportGraph(params.toJson());
  }
}
