part of 'find_one_cubit.dart';

abstract class FindOneState extends Equatable {}

class FindOneInitialState extends FindOneState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FindOneLoadingState extends FindOneState {
  @override
  List<Object> get props => [];
}

class FindOneSuccessState extends FindOneState {
  final FindOneEntity findOneEntity;

  FindOneSuccessState(this.findOneEntity);

  @override
  List<Object> get props => [findOneEntity];
}

class FindOneFailureState extends FindOneState {
  final String? errorMessage;
  final AppErrorType errorType;

  FindOneFailureState({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
