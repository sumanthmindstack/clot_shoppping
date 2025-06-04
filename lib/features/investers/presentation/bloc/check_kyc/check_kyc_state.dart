part of 'check_kyc_cubit.dart';

abstract class CheckKycState extends Equatable {
  const CheckKycState();

  @override
  List<Object> get props => [];
}

class CheckKycInitialState extends CheckKycState {}

class CheckKycLoadingState extends CheckKycState {}

class CheckKycSuccessState extends CheckKycState {
  final CheckKycEntity checkKycEntity;

  const CheckKycSuccessState(this.checkKycEntity);

  @override
  List<Object> get props => [checkKycEntity];
}

class CheckKycFailureState extends CheckKycState {
  final AppErrorType errorType;
  final String? errorMessage;

  const CheckKycFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
