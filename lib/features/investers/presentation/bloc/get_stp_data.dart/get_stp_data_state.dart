part of 'get_stp_data_cubit.dart';

abstract class GetStpDataState extends Equatable {
  const GetStpDataState();

  @override
  List<Object?> get props => [];
}

class GetStpDataInitialState extends GetStpDataState {}

class GetStpDataLoadingState extends GetStpDataState {}

class GetStpDataSuccessState extends GetStpDataState {
  final GetStpDataEntity getStpDataEntity;

  const GetStpDataSuccessState(this.getStpDataEntity);

  @override
  List<Object?> get props => [getStpDataEntity];
}

class GetStpDataFailureState extends GetStpDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetStpDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
