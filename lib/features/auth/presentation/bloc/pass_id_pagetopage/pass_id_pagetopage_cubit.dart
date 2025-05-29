import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'pass_id_pagetopage_state.dart';

@injectable
class PassIdPagetopageCubit extends Cubit<PassIdPagetopageState> {
  PassIdPagetopageCubit() : super(PassIdPagetopageState(id: 0, userId: 0));

  void setIdhere(int id, int userId) {
    print("Page to page cubit ${id}");
    print("Page to page cubit ${userId}");
    emit(PassIdPagetopageState(id: id, userId: userId));
  }

  int get getId => state.id;
  int get getUserId => state.userId;
}
