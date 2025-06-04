import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/usecase/get_lumpsum_data_usecase.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_lumpsum_data_entity.dart';
import '../../../domain/entity/params/account_summary_data_params.dart';
import '../../../domain/entity/params/get_lumpsum_data_params.dart';

part 'get_lumpsum_data_state.dart';

@injectable
class GetLumpsumDataCubit extends Cubit<GetLumpsumDataState> {
  final GetLumpsumDataUsecase _getLumpsumDataUseCase;

  GetLumpsumDataCubit(this._getLumpsumDataUseCase)
      : super(GetLumpsumDataInitialState());

  void fetchLumpsumData({
    required int userId,
    required int limit,
    required int page,
    required String type,
  }) async {
    emit(GetLumpsumDataLoadingState());

    final params = GetLumpsumDataParams(
        limit: limit, page: page, userId: userId, type: type);

    final response = await _getLumpsumDataUseCase(params);

    response.fold(
      (l) => emit(
        GetLumpsumDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetLumpsumDataSuccessState(r)),
    );
  }
}
