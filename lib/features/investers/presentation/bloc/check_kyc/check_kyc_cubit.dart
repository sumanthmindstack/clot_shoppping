import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/check_kyc_entity.dart';
import '../../../domain/entity/params/check_kyc_params.dart';
import '../../../domain/usecase/check_kyc_usecase.dart';

part 'check_kyc_state.dart';

@injectable
class CheckKycCubit extends Cubit<CheckKycState> {
  final CheckKycUsecase _checkKycUsecase;

  CheckKycCubit(this._checkKycUsecase) : super(CheckKycInitialState());

  void checkKyc({
    required String pan,
    required int userId,
  }) async {
    emit(CheckKycLoadingState());

    final params = CheckKycParams(pan: pan, userId: userId);
    final response = await _checkKycUsecase(params);

    response.fold(
      (l) => emit(
        CheckKycFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(CheckKycSuccessState(r)),
    );
  }
}
