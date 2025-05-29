part of 'ria_patch_cubit.dart';

abstract class RiaPatchState extends Equatable {
  const RiaPatchState();

  @override
  List<Object?> get props => [];
}

class RiaPatchInitialState extends RiaPatchState {}

class RiaPatchLoadingState extends RiaPatchState {}

class RiaPatchSuccessState extends RiaPatchState {
  final MfdPatchEntity mfdPatchEntity;

  const RiaPatchSuccessState(this.mfdPatchEntity);

  @override
  List<Object?> get props => [mfdPatchEntity];
}

class RiaPatchFailureState extends RiaPatchState {
  final AppErrorType errorType;
  final String? errorMessage;

  const RiaPatchFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
