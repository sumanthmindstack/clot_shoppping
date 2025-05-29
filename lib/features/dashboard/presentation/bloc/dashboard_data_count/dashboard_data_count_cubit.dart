import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/entities/dashboard_data_count_entity.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/usecase/dashboard_data_count_usecase.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../../../core/entities/no_params.dart';

part 'dashboard_data_count_state.dart';

@injectable
class DashboardDataCountCubit extends Cubit<DashboardDataCountState> {
  final DashboardDataCountUsecase _dashboardDataCountUsecase;

  DashboardDataCountCubit(this._dashboardDataCountUsecase)
      : super(DashboardDataCountInitialState());
  DashboardDatacountEntity? _dashboardData;
  DashboardDatacountEntity? get dashboardData => _dashboardData;

  void dashboardDataCount() async {
    emit(DashboardDataCountLoadingState());

    final response = await _dashboardDataCountUsecase(NoParams());
    response.fold(
      (l) => emit(
        DashboardDataCountFailureState(
            errorType: l.errorType, errorMessage: l.error),
      ),
      (r) {
        _dashboardData = r;
        final breakdownValues = [
          {'title': 'Equity', 'subtitle': '${r.data.aumReportDto.equityValue}'},
          {'title': 'Dept', 'subtitle': '${r.data.aumReportDto.debtValue}'},
          {'title': 'Hybrid', 'subtitle': '${r.data.aumReportDto.hybridValue}'},
          {
            'title': 'Alternate',
            'subtitle': '${r.data.aumReportDto.alternateValue}'
          },
        ];
        emit(DashboardDataCountSuccessState(r, breakdownValues));
      },
    );
  }
}
