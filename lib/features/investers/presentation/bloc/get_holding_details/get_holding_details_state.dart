part of 'get_holding_details_cubit.dart';

abstract class GetHoldingDetailsState extends Equatable {
  const GetHoldingDetailsState();

  @override
  List<Object?> get props => [];
}

class GetHoldingDetailsInitialState extends GetHoldingDetailsState {}

class GetHoldingDetailsLoadingState extends GetHoldingDetailsState {}

class GetHoldingDetailsSuccessState extends GetHoldingDetailsState {
  final GetHoldingDetailsEntity data;

  const GetHoldingDetailsSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class GetHoldingDetailsFailureState extends GetHoldingDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetHoldingDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
