import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_stp_data_entity.dart';
import '../../../domain/entity/params/get_lumpsum_data_params.dart';
import '../../../domain/usecase/get_stp_data_usecase.dart';

part 'get_stp_data_state.dart';

@injectable
class GetStpDataCubit extends Cubit<GetStpDataState> {
  final GetStpDataUsecase _getStpDataUseCase;

  GetStpDataCubit(this._getStpDataUseCase) : super(GetStpDataInitialState());

  void fetchStpData({
    required int userId,
    required int limit,
    required int page,
    required String type,
  }) async {
    emit(GetStpDataLoadingState());

    final params = GetLumpsumDataParams(
      limit: limit,
      page: page,
      userId: userId,
      type: type,
    );

    final response = await _getStpDataUseCase(params);

    response.fold(
      (l) => emit(
        GetStpDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetStpDataSuccessState(r)),
    );
  }
}
