import 'package:equatable/equatable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_switch_data_entity.dart';

abstract class GetSwitchDataState extends Equatable {
  const GetSwitchDataState();

  @override
  List<Object?> get props => [];
}

class GetSwitchDataInitialState extends GetSwitchDataState {}

class GetSwitchDataLoadingState extends GetSwitchDataState {}

class GetSwitchDataSuccessState extends GetSwitchDataState {
  final GetSwitchDataEntity switchDataEntity;

  const GetSwitchDataSuccessState(this.switchDataEntity);

  @override
  List<Object?> get props => [switchDataEntity];
}

class GetSwitchDataFailureState extends GetSwitchDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetSwitchDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
