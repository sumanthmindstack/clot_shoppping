import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../../../core/utils/loading_cubit.dart';
import '../../../domain/entities/mfd_patch_entity.dart';
import '../../../domain/entities/params/mfd_patch_params.dart';
import '../../../domain/usecase/mfd_patch_usecase.dart';

part 'mfd_patch_state.dart';

@injectable
class MfdPatchCubit extends Cubit<MfdPatchState> {
  final MfdPatchUsecase _mfdPatchUsecase;

  MfdPatchCubit(
    this._mfdPatchUsecase,
  ) : super(MfdPatchInitialState());

  void patchMFD({
    required String id,
    required String arnCode,
    required String arnStartDate,
    required String arnEndDate,
    required String equityName,
    required String pan,
    required bool sipDemat,
    required String tanCode,
    required String website,
  }) async {
    emit(MfdPatchLoadingState());

    final response = await _mfdPatchUsecase(
      MfdPatchParams(
        id: id,
        arnCode: arnCode,
        arnStartDate: arnStartDate,
        arnEndDate: arnEndDate,
        equityName: equityName,
        pan: pan,
        sipDemat: sipDemat,
        tanCode: tanCode,
        website: website,
      ),
    );

    response.fold(
      (l) => emit(
        MfdPatchFailureState(errorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(MfdPatchSuccessState(r)),
    );
  }
}
