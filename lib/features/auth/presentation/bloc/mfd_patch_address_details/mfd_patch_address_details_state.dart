part of 'mfd_patch_address_details_cubit.dart';

abstract class MfdPatchAddressDetailsState extends Equatable {
  const MfdPatchAddressDetailsState();

  @override
  List<Object?> get props => [];
}

class MfdPatchAddressDetailsInitialState extends MfdPatchAddressDetailsState {}

class MfdPatchAddressDetailsLoadingState extends MfdPatchAddressDetailsState {}

class MfdPatchAddressDetailsSuccessState extends MfdPatchAddressDetailsState {
  final MfdPatchEntity mfdPatchEntity;

  const MfdPatchAddressDetailsSuccessState(this.mfdPatchEntity);

  @override
  List<Object?> get props => [mfdPatchEntity];
}

class MfdPatchAddressDetailsFailureState extends MfdPatchAddressDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const MfdPatchAddressDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
