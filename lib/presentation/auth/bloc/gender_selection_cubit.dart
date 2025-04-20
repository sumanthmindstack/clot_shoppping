import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'gender_selection_state.dart';

@injectable
class GenderSelectionCubit extends Cubit<int> {
  GenderSelectionCubit() : super(1);
  int selectedIndex = 1;
  void selectGenderValue(int index) async {
    print("inside cubit here is the updated index $index");
    selectedIndex = index;
    emit(index);
  }
}
