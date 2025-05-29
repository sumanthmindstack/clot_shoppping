part of 'ria_contact_details_cubit.dart';

abstract class RiaContactDetailsState extends Equatable {
  const RiaContactDetailsState();

  @override
  List<Object?> get props => [];
}

class RiaContactDetailsInitialState extends RiaContactDetailsState {}

class RiaContactDetailsLoadingState extends RiaContactDetailsState {}

class RiaContactDetailsSuccessState extends RiaContactDetailsState {
  final MfdPatchEntity mfdPatchEntity;

  const RiaContactDetailsSuccessState(this.mfdPatchEntity);

  @override
  List<Object?> get props => [mfdPatchEntity];
}

class RiaContactDetailsFailureState extends RiaContactDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const RiaContactDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
