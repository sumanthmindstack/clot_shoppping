part of 'get_transaction_details_cubit.dart';

abstract class GetTransactionDetailsState extends Equatable {
  const GetTransactionDetailsState();

  @override
  List<Object?> get props => [];
}

class GetTransactionDetailsInitialState extends GetTransactionDetailsState {}

class GetTransactionDetailsLoadingState extends GetTransactionDetailsState {}

class GetTransactionDetailsSuccessState extends GetTransactionDetailsState {
  final GetTransactionDetailsEntity transactionDetailsEntity;

  const GetTransactionDetailsSuccessState(this.transactionDetailsEntity);

  @override
  List<Object?> get props => [transactionDetailsEntity];
}

class GetTransactionDetailsFailureState extends GetTransactionDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetTransactionDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
