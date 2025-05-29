import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'registration_flow_state.dart';

@injectable
class RegistrationFlowCubit extends Cubit<bool> {
  RegistrationFlowCubit() : super(false);

  void selectedMFD(bool isMFD) async {
    emit(isMFD);
    print("selected ${isMFD}");
  }
}
