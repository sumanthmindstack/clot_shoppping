part of 'get_user_goals_details_cubit.dart';

abstract class GetUserGoalsDetailsState extends Equatable {
  const GetUserGoalsDetailsState();

  @override
  List<Object?> get props => [];
}

class GetUserGoalsDetailsInitialState extends GetUserGoalsDetailsState {}

class GetUserGoalsDetailsLoadingState extends GetUserGoalsDetailsState {}

class GetUserGoalsDetailsSuccessState extends GetUserGoalsDetailsState {
  final UserGoalsEntity userGoalsEntity;

  const GetUserGoalsDetailsSuccessState(this.userGoalsEntity);

  @override
  List<Object?> get props => [userGoalsEntity];
}

class GetUserGoalsDetailsFailureState extends GetUserGoalsDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetUserGoalsDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
