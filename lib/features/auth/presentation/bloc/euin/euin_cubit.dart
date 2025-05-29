import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/euin_entity.dart';
import '../../../domain/entities/params/euin_params.dart';
import '../../../domain/usecase/euin_usecase.dart';

part 'euin_state.dart';

@injectable
class EuinCubit extends Cubit<EuinState> {
  final EuinUsecase _euinUsecase;

  EuinCubit(this._euinUsecase) : super(EuinInitialState());

  void euin(
      {required String userId,
      List<EuinDetails>? euinDetails,
      int? mfdId}) async {
    emit(EuinLoadingState());

    final response = await _euinUsecase(EuinParams(
        euinDetails: euinDetails!, mfdId: mfdId!, userId: int.parse(userId)));

    response.fold(
      (l) =>
          emit(EuinFailureState(errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(EuinSuccessState(euinData: r)),
    );
  }
}
