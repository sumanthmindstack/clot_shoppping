part of 'mfd_cubit.dart';

abstract class MfdState extends Equatable {}

class MfdInitialState extends MfdState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class MfdLoadingState extends MfdState {
  @override
  List<Object> get props => [];
}

class MfdSuccess extends MfdState {
  final MfdEntity mfdEntity;

  MfdSuccess(this.mfdEntity);
  @override
  List<Object> get props => [mfdEntity];
}

class MfdFailureState extends MfdState {
  final String? errorMessage;
  final AppErrorType errorType;

  MfdFailureState({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
