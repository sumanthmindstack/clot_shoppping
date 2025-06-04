import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/usecase/get_kyc_details_usecase.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_kyc_details_entity.dart';
import '../../../domain/entity/params/get_kyc_details_params.dart';

part 'get_kyc_details_state.dart';

@injectable
class GetKycDetailsCubit extends Cubit<GetKycDetailsState> {
  final GetKycDetailsUsecase _getKycDetailsUseCase;

  GetKycDetailsCubit(this._getKycDetailsUseCase)
      : super(GetKycDetailsInitialState());

  void fetchKycDetails({required int userId}) async {
    emit(GetKycDetailsLoadingState());

    final params = GetKycDetailsParams(userId: userId);
    final response = await _getKycDetailsUseCase(params);

    response.fold(
      (l) => emit(GetKycDetailsFailureState(
        errorType: l.errorType,
        errorMessage: l.error,
      )),
      (r) => emit(GetKycDetailsSuccessState(r)),
    );
  }
}
