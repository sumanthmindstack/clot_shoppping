part of 'get_all_bank_cubit.dart';

abstract class GetAllBankState extends Equatable {
  const GetAllBankState();

  @override
  List<Object?> get props => [];
}

class GetAllBankInitialState extends GetAllBankState {}

class GetAllBankLoadingState extends GetAllBankState {}

class GetAllBankSuccessState extends GetAllBankState {
  // final GetAllBankEntity data;

  const GetAllBankSuccessState();

  @override
  List<Object?> get props => [];
}

class GetAllBankFailureState extends GetAllBankState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetAllBankFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
