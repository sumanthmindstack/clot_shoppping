part of 'change_primary_bank_cubit.dart';

abstract class ChangePrimaryBankState extends Equatable {
  const ChangePrimaryBankState();

  @override
  List<Object?> get props => [];
}

class ChangePrimaryBankInitialState extends ChangePrimaryBankState {}

class ChangePrimaryBankLoadingState extends ChangePrimaryBankState {}

class ChangePrimaryBankSuccessState extends ChangePrimaryBankState {
  const ChangePrimaryBankSuccessState();

  @override
  List<Object?> get props => [];
}

class ChangePrimaryBankFailureState extends ChangePrimaryBankState {
  final AppErrorType errorType;
  final String? errorMessage;

  const ChangePrimaryBankFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
