import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../pages/widgets/add_invester_screen_widget.dart';

@injectable
class SelectedUserCubit extends Cubit<SelectedUser?> {
  SelectedUserCubit() : super(null);

  void resetUser() => emit(null);

  void selectUser(SelectedUser user) {
    emit(user);
  }
}
