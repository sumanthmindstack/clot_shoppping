part of 'account_summary_data_cubit.dart';

abstract class AccountSummaryDataState extends Equatable {
  const AccountSummaryDataState();

  @override
  List<Object?> get props => [];
}

class AccountSummaryDataInitialState extends AccountSummaryDataState {}

class AccountSummaryDataLoadingState extends AccountSummaryDataState {}

class AccountSummaryDataSuccessState extends AccountSummaryDataState {
  final AccountSummaryDataEntity accountSummaryDataEntity;

  const AccountSummaryDataSuccessState(this.accountSummaryDataEntity);

  @override
  List<Object?> get props => [accountSummaryDataEntity];
}

class AccountSummaryDataFailureState extends AccountSummaryDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const AccountSummaryDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
