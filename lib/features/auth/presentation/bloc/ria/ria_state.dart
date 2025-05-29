part of 'ria_cubit.dart';

abstract class RiaState extends Equatable {}

class RiaInitialState extends RiaState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RiaLoadingState extends RiaState {
  @override
  List<Object> get props => [];
}

class RiaSuccess extends RiaState {
  final MfdEntity mfdEntity;

  RiaSuccess(this.mfdEntity);
  @override
  List<Object> get props => [mfdEntity];
}

class RiaFailureState extends RiaState {
  final String? errorMessage;
  final AppErrorType errorType;

  RiaFailureState({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
