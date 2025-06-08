part of 'get_swp_data_cubit.dart';

abstract class GetSwpDataState extends Equatable {
  const GetSwpDataState();

  @override
  List<Object?> get props => [];
}

class GetSwpDataInitialState extends GetSwpDataState {}

class GetSwpDataLoadingState extends GetSwpDataState {}

class GetSwpDataSuccessState extends GetSwpDataState {
  final GetSwpDataEntity getSwpDataEntity;

  const GetSwpDataSuccessState(this.getSwpDataEntity);

  @override
  List<Object?> get props => [getSwpDataEntity];
}

class GetSwpDataFailureState extends GetSwpDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetSwpDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
