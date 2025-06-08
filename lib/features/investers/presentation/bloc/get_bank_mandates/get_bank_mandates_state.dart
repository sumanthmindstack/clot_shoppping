part of 'get_bank_mandates_cubit.dart';

abstract class GetBankMandatesState extends Equatable {
  const GetBankMandatesState();

  @override
  List<Object?> get props => [];
}

class GetBankMandatesInitialState extends GetBankMandatesState {}

class GetBankMandatesLoadingState extends GetBankMandatesState {}

class GetBankMandatesSuccessState extends GetBankMandatesState {
  final GetBankMandatesEntity getBankMandateEntity;

  const GetBankMandatesSuccessState(this.getBankMandateEntity);

  @override
  List<Object?> get props => [getBankMandateEntity];
}

class GetBankMandatesFailureState extends GetBankMandatesState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetBankMandatesFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
