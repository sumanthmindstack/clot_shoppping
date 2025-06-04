part of 'add_new_bank_cubit.dart';

abstract class AddNewBankState extends Equatable {
  const AddNewBankState();

  @override
  List<Object?> get props => [];
}

class AddNewBankInitialState extends AddNewBankState {}

class AddNewBankLoadingState extends AddNewBankState {}

class AddNewBankSuccessState extends AddNewBankState {
  const AddNewBankSuccessState();

  @override
  List<Object?> get props => [];
}

class AddNewBankFailureState extends AddNewBankState {
  final AppErrorType errorType;
  final String? errorMessage;

  const AddNewBankFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
