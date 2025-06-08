import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entity/params/get_lumpsum_data_params.dart';
import '../../../domain/usecase/get_switch_data_usecase.dart';
import 'get_switch_data_state.dart';

@injectable
class GetSwitchDataCubit extends Cubit<GetSwitchDataState> {
  final GetSwitchDataUsecase _getSwitchDataUseCase;

  GetSwitchDataCubit(this._getSwitchDataUseCase)
      : super(GetSwitchDataInitialState());

  void fetchSwitchData({
    required int userId,
    required int limit,
    required int page,
    required String type,
  }) async {
    emit(GetSwitchDataLoadingState());

    final params = GetLumpsumDataParams(
      type: type,
      userId: userId,
      limit: limit,
      page: page,
    );

    final response = await _getSwitchDataUseCase(params);

    response.fold(
      (l) => emit(
        GetSwitchDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetSwitchDataSuccessState(r)),
    );
  }
}
