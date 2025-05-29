import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'selected_type_state.dart';

@injectable
class SelectedTypeCubit extends Cubit<String> {
  SelectedTypeCubit() : super("Users");

  void selectType(String type) {
    emit(type);
  }
}
