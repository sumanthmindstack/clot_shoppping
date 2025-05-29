import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'ria_flow_check_state.dart';

@injectable
class RiaFlowCheckCubit extends Cubit<List<int>> {
  RiaFlowCheckCubit() : super([-1]);
  Future<void> setRIARegistrationFlowCheck(int index) async {
    final updatedList = List.generate(index + 1, (i) => i);
    emit(updatedList);
  }
}
