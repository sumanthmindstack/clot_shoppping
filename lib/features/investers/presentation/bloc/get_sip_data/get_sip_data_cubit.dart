import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/usecase/get_sip_data_usecase.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_sip_data_entity.dart';
import '../../../domain/entity/params/get_lumpsum_data_params.dart';

part 'get_sip_data_state.dart';

@injectable
class GetSipDataCubit extends Cubit<GetSipDataState> {
  final GetSipDataUsecase _getSipDataUseCase;

  GetSipDataCubit(this._getSipDataUseCase) : super(GetSipDataInitialState());

  void fetchSipData({
    required int userId,
    required int limit,
    required int page,
    required String type,
  }) async {
    emit(GetSipDataLoadingState());

    final params = GetLumpsumDataParams(
      type: type,
      userId: userId,
      limit: limit,
      page: page,
    );

    final response = await _getSipDataUseCase(params);

    response.fold(
      (l) => emit(
        GetSipDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetSipDataSuccessState(r)),
    );
  }
}
