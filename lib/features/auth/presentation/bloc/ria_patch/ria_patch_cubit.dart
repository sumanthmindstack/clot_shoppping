import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/mfd_patch_entity.dart';
import '../../../domain/entities/params/ria_patch_params.dart';
import '../../../domain/usecase/ria_patch_usecase.dart';

part 'ria_patch_state.dart';

@injectable
class RiaPatchCubit extends Cubit<RiaPatchState> {
  final RiaPatchUsecase _riaPatchUsecase;

  RiaPatchCubit(
    this._riaPatchUsecase,
  ) : super(RiaPatchInitialState());

  void patchRIA({
    required String id,
    required String riaCode,
    required String equityName,
    required String equityShortCode,
    required String pan,
    required bool sipDemat,
    required String tanCode,
    required String website,
  }) async {
    emit(RiaPatchLoadingState());

    final response = await _riaPatchUsecase(
      RiaPatchParams(
        id: id,
        equityShortCode: equityShortCode,
        riaCode: riaCode,
        equityName: equityName,
        pan: pan,
        sipDemat: sipDemat,
        tanCode: tanCode,
        website: website,
      ),
    );

    response.fold(
      (l) => emit(
        RiaPatchFailureState(errorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(RiaPatchSuccessState(r)),
    );
  }
}
