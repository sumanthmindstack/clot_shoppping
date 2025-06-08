part of 'get_sip_data_cubit.dart';

abstract class GetSipDataState extends Equatable {
  const GetSipDataState();

  @override
  List<Object?> get props => [];
}

class GetSipDataInitialState extends GetSipDataState {}

class GetSipDataLoadingState extends GetSipDataState {}

class GetSipDataSuccessState extends GetSipDataState {
  final GetSipDataEntity data;

  const GetSipDataSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class GetSipDataFailureState extends GetSipDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetSipDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
