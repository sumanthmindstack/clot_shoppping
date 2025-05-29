import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/dashboard/domain/entities/params/dash_monthwise_user_details_graph_params.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/dash_monthwise_user_details_graph_entity.dart';
import '../../../domain/usecase/dash_monthwise_invester_details_graph_usecase.dart';

part 'dash_monthwise_invester_details_graph_state.dart';

@injectable
class DashMonthwiseInvesterDetailsGraphCubit
    extends Cubit<DashMonthwiseInvesterDetailsGraphState> {
  final DashMonthwiseInvesterDetailsGraphUsecase _usecase;

  DashMonthwiseInvesterDetailsGraphCubit(this._usecase)
      : super(DashMonthwiseInvesterDetailsGraphInitialState());

  void fetchMonthwiseInvesterDetailsGraph({
    required String filter,
    required int year,
  }) async {
    emit(DashMonthwiseInvesterDetailsGraphLoadingState());

    final params =
        DashMonthwiseUserDetailsGraphParams(filter: filter, year: year);
    final response = await _usecase(params);

    response.fold(
      (l) => emit(
        DashMonthwiseInvesterDetailsGraphFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(DashMonthwiseInvesterDetailsGraphSuccessState(r)),
    );
  }
}
