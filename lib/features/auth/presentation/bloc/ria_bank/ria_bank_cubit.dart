import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/params/ria_bank_params.dart';
import '../../../domain/entities/ria_bank_entity.dart';
import '../../../domain/usecase/ria_bank_usecase.dart';

part 'ria_bank_state.dart';

@injectable
class RiaBankCubit extends Cubit<RiaBankState> {
  final RiaBankUsecase _riaBankUsecase;

  RiaBankCubit(this._riaBankUsecase) : super(RiaBankInitialState());

  void uploadRiaBank({
    required String accountNumber,
    required String accountType,
    required String bankName,
    required String bankProof,
    required String benificiaryName,
    required String branchName,
    required String fundTransferNotificationEmail,
    required String ifscCode,
    required String micrCode,
    required int riaId,
    required int userId,
  }) async {
    emit(RiaBankLoadingState());

    final bankDetail = BankDetail(
      accountNumber: accountNumber,
      accountType: accountType,
      bankName: bankName,
      bankProof: bankProof,
      benificiaryName: benificiaryName,
      branchName: branchName,
      fundTransferNotificationEmail: fundTransferNotificationEmail,
      ifscCode: ifscCode,
      micrCode: micrCode,
    );

    final params = RiaBankParams(
      riaId: riaId,
      userId: userId,
      bankDetails: [bankDetail],
    );

    final response = await _riaBankUsecase(params);

    response.fold(
      (l) => emit(
        RiaBankFailureState(errorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(RiaBankSuccessState(r)),
    );
  }
}
