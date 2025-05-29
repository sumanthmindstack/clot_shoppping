part of 'generate_otp_cubit.dart';

abstract class GenerateOtpState extends Equatable {}

class GenerateOtpIntialState extends GenerateOtpState {
  @override
  List<Object> get props => [];
}

class GenerateOtpLoadingState extends GenerateOtpState {
  @override
  List<Object> get props => [];
}

class GenertateOtpSuccessState extends GenerateOtpState {
  @override
  List<Object> get props => [];
}

class GenertateOtpFailureState extends GenerateOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  GenertateOtpFailureState({this.errorMessage, required this.errorType});
  @override
  List<Object?> get props => [errorMessage, errorType];
}

abstract class ReGenerateOtpState extends Equatable {}

class ReGenerateOtpIntialState extends ReGenerateOtpState {
  @override
  List<Object> get props => [];
}

class ReGenerateOtpLoadingState extends ReGenerateOtpState {
  @override
  List<Object> get props => [];
}

class ReGenertateOtpSuccessState extends ReGenerateOtpState {
  @override
  List<Object> get props => [];
}

class ReGenertateOtpFailureState extends ReGenerateOtpState {
  final String? errorMessage;
  final AppErrorType errorType;

  ReGenertateOtpFailureState({this.errorMessage, required this.errorType});
  @override
  List<Object?> get props => [errorMessage, errorType];
}
