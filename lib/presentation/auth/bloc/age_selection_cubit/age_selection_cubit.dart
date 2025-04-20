import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'age_selection_state.dart';

@injectable
class AgeSelectionCubit extends Cubit<String> {
  AgeSelectionCubit() : super("Age Range");
  String selectedAge = "Age Range";
  void selectAge() {}
}
