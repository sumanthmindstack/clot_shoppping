import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../../../core/entities/no_params.dart';
import '../../../domain/entities/trans_typewise_returns_entity.dart';
import '../../../domain/usecase/trans_typewise_returns_usecase.dart';

part 'trans_typewise_returns_state.dart';

@injectable
class TransTypewiseReturnsCubit extends Cubit<TransTypewiseReturnsState> {
  final TransTypewiseReturnsUsecase _usecase;

  TransTypewiseReturnsCubit(this._usecase)
      : super(TransTypewiseReturnsInitialState());

  void fetchTransTypewiseReturns() async {
    emit(TransTypewiseReturnsLoadingState());

    final response = await _usecase(NoParams());

    response.fold(
      (l) => emit(
        TransTypewiseReturnsFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) {
        final breakdownValues = [
          {'title': 'SIP', 'subtitle': '${r.data[0].total}'},
          {'title': 'Lumpsum', 'subtitle': '${r.data[1].total}'},
          {'title': 'Switch', 'subtitle': '${r.data[3].total}'},
          {'title': 'Redemption', 'subtitle': '${r.data[2].total}'},
          {'title': 'SWP', 'subtitle': '${r.data[4].total}'},
          {'title': 'STP', 'subtitle': '${r.data[5].total}'},
        ];

        emit(TransTypewiseReturnsSuccessState(
          transTypewiseReturnsResponseEntity: r,
          breakdownValues: breakdownValues,
        ));
      },
    );
  }
}
