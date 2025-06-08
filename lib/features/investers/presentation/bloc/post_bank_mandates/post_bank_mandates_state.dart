import 'package:equatable/equatable.dart';

import '../../../../../core/entities/app_error.dart';

abstract class PostBankMandatesState extends Equatable {
  const PostBankMandatesState();

  @override
  List<Object?> get props => [];
}

class PostBankMandatesInitial extends PostBankMandatesState {}

class PostBankMandatesLoading extends PostBankMandatesState {}

class PostBankMandatesSuccess extends PostBankMandatesState {}

class PostBankMandatesFailure extends PostBankMandatesState {
  final AppErrorType errorType;
  final String? errorMessage;

  const PostBankMandatesFailure({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
