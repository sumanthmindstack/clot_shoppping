import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/params/generate_otp_params.dart';
import '../../../domain/usecase/generate_otp_usecase.dart';

part 'generate_otp_state.dart';

@injectable
class GenerateOtpCubit extends Cubit<GenerateOtpState> {
  final GenerateOtpUsecase _generateOtpUsecase;

  GenerateOtpCubit(this._generateOtpUsecase) : super(GenerateOtpIntialState());
  void generateOtp(String mobileNumber) async {
    emit(GenerateOtpLoadingState());
    final response = await _generateOtpUsecase(
        GenerateOtpParams(mobileNumber: mobileNumber));
    response.fold(
      (l) => emit(GenertateOtpFailureState(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(GenertateOtpSuccessState()),
    );
  }
}

@injectable
class ReGenerateOtpCubit extends Cubit<ReGenerateOtpState> {
  final GenerateOtpUsecase _generateOtpUsecase;

  ReGenerateOtpCubit(this._generateOtpUsecase)
      : super(ReGenerateOtpIntialState());
  void reGenerateOtp(String mobileNumber) async {
    emit(ReGenerateOtpLoadingState());
    final response = await _generateOtpUsecase(
        GenerateOtpParams(mobileNumber: mobileNumber));
    response.fold(
      (l) => emit(ReGenertateOtpFailureState(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(ReGenertateOtpSuccessState()),
    );
  }
}
