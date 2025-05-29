import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/dash_monthwise_trans_details_graph_entity.dart';
import '../../../domain/entities/params/dash_monthwise_trans_details_graph_params.dart';
import '../../../domain/usecase/dash_monthwise_trans_details_graph_usecase.dart';

part 'dash_monthwise_trans_details_graph_state.dart';

@injectable
class DashMonthwiseTransDetailsGraphCubit
    extends Cubit<DashMonthwiseTransDetailsGraphState> {
  final DashMonthwiseTransDetailsGraphUsecase _usecase;

  DashMonthwiseTransDetailsGraphCubit(this._usecase)
      : super(DashMonthwiseTransDetailsGraphInitialState());

  void fetchMonthwiseTransDetailsGraph({
    required int year,
  }) async {
    emit(DashMonthwiseTransDetailsGraphLoadingState());

    final params = DashMonthwiseTransDetailsGraphParams(year: year);
    final response = await _usecase(params);

    response.fold(
      (l) => emit(
        DashMonthwiseTransDetailsGraphFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(DashMonthwiseTransDetailsGraphSuccessState(r)),
    );
  }
}
