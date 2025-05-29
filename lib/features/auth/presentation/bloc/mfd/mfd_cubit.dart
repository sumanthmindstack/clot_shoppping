import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/mfd_entity.dart';
import '../../../domain/entities/params/mfd_params.dart';
import '../../../domain/usecase/mfd_usecase.dart';

part 'mfd_state.dart';

@injectable
class MfdCubit extends Cubit<MfdState> {
  final MfdUsecase _mfdUsecase;

  MfdCubit(this._mfdUsecase) : super(MfdInitialState());

  void mfd({
    String? userId,
  }) async {
    emit(MfdLoadingState());
    final response = await _mfdUsecase(MfdParams(userId: userId!));
    response.fold(
      (l) =>
          emit(MfdFailureState(errorType: l.errorType, errorMessage: l.error)),
      (r) {
        emit(MfdSuccess(r));
      },
    );
  }
}
