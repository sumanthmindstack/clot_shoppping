import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/params/verify_otp_params.dart';
import '../../../domain/usecase/verify_otp_usecase.dart';

part 'verify_otp_state.dart';

@injectable
class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUsecase _verifyOtpUsecase;

  VerifyOtpCubit(this._verifyOtpUsecase) : super(VerifyOtpInitialState());
  void verifyOTP({String? mobileNumber, String? otp}) async {
    emit(VerifyOtpLoadingState());
    final response = await _verifyOtpUsecase(
        VerifyOtpParams(mobileNumber: mobileNumber!, otp: otp!));
    response.fold(
      (l) => emit(
          VerifyOtpFailureState(errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(VerifyOtpSuccessState()),
    );
  }
}
