part of 'edit_invester_details_cubit.dart';

abstract class EditInvesterDetailsState extends Equatable {
  const EditInvesterDetailsState();

  @override
  List<Object?> get props => [];
}

class EditInvesterDetailsInitialState extends EditInvesterDetailsState {}

class EditInvesterDetailsLoadingState extends EditInvesterDetailsState {}

class EditInvesterDetailsSuccessState extends EditInvesterDetailsState {
  const EditInvesterDetailsSuccessState();

  @override
  List<Object?> get props => [];
}

class EditInvesterDetailsFailureState extends EditInvesterDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const EditInvesterDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
