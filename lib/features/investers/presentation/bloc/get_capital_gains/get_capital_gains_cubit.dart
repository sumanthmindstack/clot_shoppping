import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_capital_gains_entity.dart';
import '../../../domain/entity/params/account_summary_data_params.dart';
import '../../../domain/usecase/get_capital_gains_usecase.dart';

part 'get_capital_gains_state.dart';

@injectable
class GetCapitalGainsCubit extends Cubit<GetCapitalGainsState> {
  final GetCapitalGainsUsecase _getCapitalGainsUsecase;

  GetCapitalGainsCubit(this._getCapitalGainsUsecase)
      : super(GetCapitalGainsInitialState());

  void fetchCapitalGains({
    required int userId,
    required int page,
    required int limit,
  }) async {
    emit(GetCapitalGainsLoadingState());

    final params = AccountSummaryDataParams(
      userId: userId,
      page: page,
      limit: limit,
    );

    final response = await _getCapitalGainsUsecase(params);

    response.fold(
      (l) => emit(
        GetCapitalGainsFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetCapitalGainsSuccessState(r)),
    );
  }
}
