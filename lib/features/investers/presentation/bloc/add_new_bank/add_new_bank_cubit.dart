import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/params/add_new_bank_params.dart';
import '../../../domain/usecase/add_new_bank_usecase.dart';

part 'add_new_bank_state.dart';

@injectable
class AddNewBankCubit extends Cubit<AddNewBankState> {
  final AddNewBankUsecase _addNewBankUsecase;

  AddNewBankCubit(this._addNewBankUsecase) : super(AddNewBankInitialState());

  void addNewBank({
    required String accountHolderName,
    required String accountNumber,
    required String bankName,
    required String ifscCode,
    required int userId,
  }) async {
    emit(AddNewBankLoadingState());

    final params = AddNewBankParams(
      accountHolderName: accountHolderName,
      accountNumber: accountNumber,
      bankName: bankName,
      ifscCode: ifscCode,
      userId: userId,
    );

    final response = await _addNewBankUsecase(params);

    response.fold(
      (l) => emit(
        AddNewBankFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(const AddNewBankSuccessState()),
    );
  }
}
