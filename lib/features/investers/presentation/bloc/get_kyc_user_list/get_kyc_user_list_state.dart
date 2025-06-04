part of 'get_kyc_user_list_cubit.dart';

abstract class GetKycUserListState extends Equatable {
  const GetKycUserListState();

  @override
  List<Object> get props => [];
}

class GetKycUserListInitialState extends GetKycUserListState {}

class GetKycUserListLoadingState extends GetKycUserListState {}

class GetKycUserListSuccessState extends GetKycUserListState {
  final GetKycUserListEntity kycUserList;

  const GetKycUserListSuccessState(this.kycUserList);

  @override
  List<Object> get props => [kycUserList];
}

class GetKycUserListFailureState extends GetKycUserListState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetKycUserListFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
