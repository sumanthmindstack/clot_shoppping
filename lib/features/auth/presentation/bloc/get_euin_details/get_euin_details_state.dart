part of 'get_euin_details_cubit.dart';

abstract class GetEuinDetailsState extends Equatable {
  const GetEuinDetailsState();

  @override
  List<Object?> get props => [];
}

class GetEuinDetailsInitialState extends GetEuinDetailsState {}

class GetEuinDetailsLoadingState extends GetEuinDetailsState {}

class GetEuinDetailsSuccessState extends GetEuinDetailsState {
  final GetEuinDetailsEntity? euinDetailsEntity;

  const GetEuinDetailsSuccessState(this.euinDetailsEntity);
  @override
  List<Object?> get props => [euinDetailsEntity];
}

class GetEuinDetailsFailureState extends GetEuinDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetEuinDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
