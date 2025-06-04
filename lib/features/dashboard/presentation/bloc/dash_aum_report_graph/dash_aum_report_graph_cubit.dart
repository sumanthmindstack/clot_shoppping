import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/dash_aum_report_graph_entity.dart';
import '../../../domain/entities/params/dash_monthwise_trans_details_graph_params.dart';
import '../../../domain/usecase/dash_aum_report_graph_usecase.dart';

part 'dash_aum_report_graph_state.dart';

@injectable
class DashAumReportGraphCubit extends Cubit<DashAumReportGraphState> {
  final DashAumReportGraphUsecase _dashAumReportGraphUsecase;

  DashAumReportGraphState? _previousState;

  DashAumReportGraphCubit(this._dashAumReportGraphUsecase)
      : super(DashAumReportGraphInitialState());

  DashAumReportGraphState? get previousState => _previousState;

  void fetchAumReportGraph({
    required int year,
  }) async {
    _previousState = state;

    emit(DashAumReportGraphLoadingState());

    final params = DashMonthwiseTransDetailsGraphParams(year: year);
    final response = await _dashAumReportGraphUsecase(params);

    response.fold(
      (l) => emit(
        DashAumReportGraphFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(DashAumReportGraphSuccessState(r)),
    );
  }
}
