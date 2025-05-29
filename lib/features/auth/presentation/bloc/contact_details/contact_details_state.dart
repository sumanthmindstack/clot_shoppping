part of 'contact_details_cubit.dart';

abstract class ContactDetailsState extends Equatable {
  const ContactDetailsState();

  @override
  List<Object?> get props => [];
}

class ContactDetailsInitialState extends ContactDetailsState {}

class ContactDetailsLoadingState extends ContactDetailsState {}

class ContactDetailsSuccessState extends ContactDetailsState {
  final MfdPatchEntity mfdPatchEntity;

  const ContactDetailsSuccessState(this.mfdPatchEntity);

  @override
  List<Object?> get props => [mfdPatchEntity];
}

class ContactDetailsFailureState extends ContactDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const ContactDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
