import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/params/mfd_params.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/get_euin_details_entity.dart';
import '../../../domain/usecase/get_euin_details_usecase.dart';

part 'get_euin_details_state.dart';

@injectable
class GetEuinDetailsCubit extends Cubit<GetEuinDetailsState> {
  final GetEUINDetailsUsecase _getEuinDetailsUsecase;

  GetEuinDetailsCubit(this._getEuinDetailsUsecase)
      : super(GetEuinDetailsInitialState());

  void getEuinDetails({required String userId}) async {
    emit(GetEuinDetailsLoadingState());

    final response = await _getEuinDetailsUsecase(MfdParams(userId: userId));

    response.fold(
      (l) => emit(GetEuinDetailsFailureState(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(GetEuinDetailsSuccessState(r)),
    );
  }
}
