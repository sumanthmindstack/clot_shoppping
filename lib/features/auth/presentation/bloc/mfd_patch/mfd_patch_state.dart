part of 'mfd_patch_cubit.dart';

abstract class MfdPatchState extends Equatable {
  const MfdPatchState();

  @override
  List<Object?> get props => [];
}

class MfdPatchInitialState extends MfdPatchState {}

class MfdPatchLoadingState extends MfdPatchState {}

class MfdPatchSuccessState extends MfdPatchState {
  final MfdPatchEntity mfdPatchEntity;

  const MfdPatchSuccessState(this.mfdPatchEntity);

  @override
  List<Object?> get props => [mfdPatchEntity];
}

class MfdPatchFailureState extends MfdPatchState {
  final AppErrorType errorType;
  final String? errorMessage;

  const MfdPatchFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
