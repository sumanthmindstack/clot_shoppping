part of 'trans_typewise_returns_cubit.dart';

abstract class TransTypewiseReturnsState extends Equatable {
  const TransTypewiseReturnsState();

  @override
  List<Object?> get props => [];
}

class TransTypewiseReturnsInitialState extends TransTypewiseReturnsState {}

class TransTypewiseReturnsLoadingState extends TransTypewiseReturnsState {}

class TransTypewiseReturnsFailureState extends TransTypewiseReturnsState {
  final String? errorMessage;
  final AppErrorType errorType;

  const TransTypewiseReturnsFailureState({
    required this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object?> get props => [errorMessage, errorType];
}

class TransTypewiseReturnsSuccessState extends TransTypewiseReturnsState {
  final TransTypewiseReturnsResponseEntity transTypewiseReturnsResponseEntity;
  final List<Map<String, String>> breakdownValues;

  const TransTypewiseReturnsSuccessState({
    required this.transTypewiseReturnsResponseEntity,
    required this.breakdownValues,
  });

  @override
  List<Object?> get props =>
      [transTypewiseReturnsResponseEntity, breakdownValues];
}
