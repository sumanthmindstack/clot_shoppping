import 'package:equatable/equatable.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/dash_monthwise_sip_details_graph_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/params/dash_monthwise_sip_details_graph_params.dart';
import '../../../domain/usecase/dash_monthwise_sip_details_graph_usecase.dart';
part 'dash_monthwise_sip_details_graph_state.dart';

@injectable
class DashMonthwiseSipDetailsGraphCubit
    extends Cubit<DashMonthwiseSipDetailsGraphState> {
  final DashMonthwiseSipDetailsGraphUsecase _usecase;

  DashMonthwiseSipDetailsGraphCubit(this._usecase)
      : super(DashMonthwiseSipDetailsGraphInitialState());

  void fetchDashMonthwiseSipDetailsGraph({
    required int year,
  }) async {
    emit(DashMonthwiseSipDetailsGraphLoadingState());
    final params = DashMonthwiseSipDetailsGraphParams(year: year, type: "sip");
    final response = await _usecase(params);

    response.fold(
      (l) => emit(DashMonthwiseSipDetailsGraphFailureState(
        errorMessage: l.error,
        errorType: l.errorType,
      )),
      (r) {
        final graphData = r.data.map((item) {
          return {
            'month': item.month,
            'value': item.month,
          };
        }).toList();

        emit(DashMonthwiseSipDetailsGraphSuccessState(
          dashMonthwiseSipDetailsGraphEntity: r,
          graphData: graphData,
        ));
      },
    );
  }
}
