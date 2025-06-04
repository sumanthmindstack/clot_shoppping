import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class InputSelectionCubit extends Cubit<bool> {
  InputSelectionCubit() : super(false);

  void selectInput() {
    emit(true);
  }

  void deselectInput() {
    emit(false);
  }
}
