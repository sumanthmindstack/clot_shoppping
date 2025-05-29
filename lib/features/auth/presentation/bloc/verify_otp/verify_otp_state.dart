part of 'verify_otp_cubit.dart';

abstract class VerifyOtpState extends Equatable {}

class VerifyOtpInitialState extends VerifyOtpState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class VerifyOtpLoadingState extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

class VerifyOtpSuccessState extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

class VerifyOtpFailureState extends VerifyOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  VerifyOtpFailureState({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
