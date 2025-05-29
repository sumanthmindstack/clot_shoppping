import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/mfd_entity.dart';
import '../../../domain/entities/params/mfd_params.dart';
import '../../../domain/usecase/ria_usecase.dart';

part 'ria_state.dart';

@injectable
class RiaCubit extends Cubit<RiaState> {
  final RiaUsecase _riaUsecase;

  RiaCubit(this._riaUsecase) : super(RiaInitialState());

  void ria({
    String? userId,
  }) async {
    emit(RiaLoadingState());
    final response = await _riaUsecase(MfdParams(userId: userId!));
    response.fold(
      (l) =>
          emit(RiaFailureState(errorType: l.errorType, errorMessage: l.error)),
      (r) {
        emit(RiaSuccess(r));
      },
    );
  }
}
