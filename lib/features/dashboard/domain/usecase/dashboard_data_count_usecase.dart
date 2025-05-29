import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/entities/dashboard_data_count_entity.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/repository/home_dash_repo.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/entities/no_params.dart';
import '../../../../core/usecase/usecase.dart';

@injectable
class DashboardDataCountUsecase
    implements Usecase<DashboardDatacountEntity, NoParams> {
  final HomeDashRepo _homeDashRepo;

  DashboardDataCountUsecase(this._homeDashRepo);

  @override
  Future<Either<AppError, DashboardDatacountEntity>> call(
      NoParams noParams) async {
    return await _homeDashRepo.dashboardDataCount();
  }
}
