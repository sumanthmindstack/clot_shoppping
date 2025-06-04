import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class KycMessageCubit extends Cubit<bool?> {
  KycMessageCubit() : super(null);

  void showMessageForDuration(Duration duration, bool value) {
    print("here is the cubit value");
    emit(value);
    Future.delayed(duration, () {
      emit(null);
    });
  }

  void reset() {
    emit(null);
  }
}
