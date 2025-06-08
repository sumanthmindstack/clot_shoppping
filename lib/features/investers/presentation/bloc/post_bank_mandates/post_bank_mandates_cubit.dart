import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entity/params/post_bank_mandates_params.dart';
import '../../../domain/usecase/post_bank_mandates_usecase.dart';
import 'post_bank_mandates_state.dart';

@injectable
class PostBankMandatesCubit extends Cubit<PostBankMandatesState> {
  final PostBankMandatesUsecase _postBankMandatesUsecase;

  PostBankMandatesCubit(this._postBankMandatesUsecase)
      : super(PostBankMandatesInitial());

  Future<void> postBankMandate(PostBankMandatesParams params) async {
    emit(PostBankMandatesLoading());
    final result = await _postBankMandatesUsecase.call(params);
    result.fold(
      (l) => emit(PostBankMandatesFailure(
        errorType: l.errorType,
        errorMessage: l.error,
      )),
      (_) => emit(PostBankMandatesSuccess()),
    );
  }
}
