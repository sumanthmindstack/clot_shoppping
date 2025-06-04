part of 'get_lumpsum_data_cubit.dart';

abstract class GetLumpsumDataState extends Equatable {
  const GetLumpsumDataState();

  @override
  List<Object?> get props => [];
}

class GetLumpsumDataInitialState extends GetLumpsumDataState {}

class GetLumpsumDataLoadingState extends GetLumpsumDataState {}

class GetLumpsumDataSuccessState extends GetLumpsumDataState {
  final GetLumpsumDataEntity data;

  const GetLumpsumDataSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class GetLumpsumDataFailureState extends GetLumpsumDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetLumpsumDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
