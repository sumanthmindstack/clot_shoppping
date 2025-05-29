import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'mfd_flow_check_state.dart';

@injectable
class MfdFlowCheckCubit extends Cubit<List<int>> {
  MfdFlowCheckCubit() : super([-1]);

  Future<void> setMFDRegistrationFlowCheck(int index) async {
    final updatedList = List.generate(index + 1, (i) => i);
    emit(updatedList);
  }
}
