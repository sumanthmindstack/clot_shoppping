part of 'get_capital_gains_cubit.dart';

abstract class GetCapitalGainsState extends Equatable {
  const GetCapitalGainsState();

  @override
  List<Object?> get props => [];
}

class GetCapitalGainsInitialState extends GetCapitalGainsState {}

class GetCapitalGainsLoadingState extends GetCapitalGainsState {}

class GetCapitalGainsSuccessState extends GetCapitalGainsState {
  final GetCapitalGainsEntity getCapitalGainsEntity;

  const GetCapitalGainsSuccessState(this.getCapitalGainsEntity);

  @override
  List<Object?> get props => [getCapitalGainsEntity];
}

class GetCapitalGainsFailureState extends GetCapitalGainsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetCapitalGainsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
