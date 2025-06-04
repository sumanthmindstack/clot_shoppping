import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/params/change_primary_bank_params.dart';
import '../../../domain/usecase/change_primary_bank_usecase.dart';

part 'change_primary_bank_state.dart';

@injectable
class ChangePrimaryBankCubit extends Cubit<ChangePrimaryBankState> {
  final ChangePrimaryBankUsecase _changePrimaryBankUsecase;

  ChangePrimaryBankCubit(this._changePrimaryBankUsecase)
      : super(ChangePrimaryBankInitialState());

  void changePrimaryBank({
    required int userId,
    required int bankId,
  }) async {
    emit(ChangePrimaryBankLoadingState());

    final params = ChangePrimaryBankParams(
      userId: userId,
      bankId: bankId,
    );

    final response = await _changePrimaryBankUsecase(params);

    response.fold(
      (l) => emit(
        ChangePrimaryBankFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(const ChangePrimaryBankSuccessState()),
    );
  }
}
