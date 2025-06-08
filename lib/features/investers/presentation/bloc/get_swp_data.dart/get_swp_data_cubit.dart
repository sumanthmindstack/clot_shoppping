import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_swp_data_entity.dart';
import '../../../domain/entity/params/get_lumpsum_data_params.dart';
import '../../../domain/usecase/get_swp_data_usecase.dart';

part 'get_swp_data_state.dart';

@injectable
class GetSwpDataCubit extends Cubit<GetSwpDataState> {
  final GetSwpDataUsecase _getSwpDataUseCase;

  GetSwpDataCubit(this._getSwpDataUseCase) : super(GetSwpDataInitialState());

  void fetchSwpData({
    required int userId,
    required int limit,
    required int page,
    required String type,
  }) async {
    emit(GetSwpDataLoadingState());

    final params = GetLumpsumDataParams(
      limit: limit,
      page: page,
      userId: userId,
      type: type,
    );

    final response = await _getSwpDataUseCase(params);

    response.fold(
      (l) => emit(
        GetSwpDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetSwpDataSuccessState(r)),
    );
  }
}
